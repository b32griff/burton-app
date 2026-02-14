import Foundation

@Observable
class SwingMemoryManager {
    var swingProfile: SwingProfile

    init() {
        self.swingProfile = UserDefaultsManager.loadSwingProfile()
    }

    func buildMemoryContext() -> String {
        guard !swingProfile.isEmpty else { return "" }

        var parts: [String] = []

        if !swingProfile.summary.isEmpty {
            parts.append("Overall: \(swingProfile.summary)")
        }
        if !swingProfile.prioritizedIssues.isEmpty {
            let sorted = swingProfile.prioritizedIssues.sorted { $0.priority.sortOrder < $1.priority.sortOrder }
            let issueList = sorted.map { "\($0.name) (\($0.priority.rawValue))" }.joined(separator: ", ")
            parts.append("Issues by priority: \(issueList)")
        } else if !swingProfile.identifiedIssues.isEmpty {
            parts.append("Issues: \(swingProfile.identifiedIssues.joined(separator: ", "))")
        }
        if !swingProfile.strengths.isEmpty {
            parts.append("Strengths: \(swingProfile.strengths.joined(separator: ", "))")
        }
        if !swingProfile.currentFocusAreas.isEmpty {
            parts.append("Focus: \(swingProfile.currentFocusAreas.joined(separator: ", "))")
        }

        let recent = swingProfile.progressNotes.suffix(3)
        if !recent.isEmpty {
            parts.append("Recent progress: " + recent.map { "[\($0.date.shortFormatted)] \($0.note)" }.joined(separator: "; "))
        }

        let recentSessions = swingProfile.sessionHistory.suffix(5)
        if !recentSessions.isEmpty {
            let sessionLines = recentSessions.map { record in
                "- [\(record.date.shortFormatted)] Root cause: '\(record.rootCause)'. Drill: '\(record.assignedDrill)'. Score: \(record.overallScore)/10."
            }
            parts.append("Session history:\n" + sessionLines.joined(separator: "\n"))
        }

        return parts.joined(separator: "\n")
    }

    func updateProfile(from conversation: Conversation, hasVideo: Bool = false) async {
        debugLog("updateProfile called with \(conversation.messages.count) messages, hasVideo: \(hasVideo)")
        guard conversation.messages.count >= 2 else {
            debugLog("Skipped — not enough messages")
            return
        }

        let conversationSummary = conversation.messages.map { msg in
            "\(msg.role.rawValue): \(msg.content.prefix(300))"
        }.joined(separator: "\n")

        let currentProfileJSON: String
        if let data = try? JSONEncoder().encode(swingProfile),
           let json = String(data: data, encoding: .utf8) {
            currentProfileJSON = json
        } else {
            currentProfileJSON = "{}"
        }

        let issueNames = SwingIssueData.all.map(\.name)
        let drillCatalog = DrillData.all.map { "\($0.id): \($0.name) (\($0.category.rawValue), \($0.difficulty.rawValue))" }.joined(separator: "\n")

        let systemPrompt = """
        You are a golf coaching data analyst. Given a conversation between a golf coach and student, update the student's swing profile JSON. Merge new information with existing data — don't remove things unless explicitly corrected.

        IMPORTANT: For "identifiedIssues" and "prioritizedIssues", use values from this list when applicable: \(issueNames.joined(separator: ", ")).

        For "prioritizedIssues", assign each issue a priority:
        - "high": Most impactful problem to fix first. Usually 1-2 max.
        - "medium": Important but secondary.
        - "low": Minor or awareness-level.

        For "recommendedDrills", pick the MOST RELEVANT drills for THIS specific user based on what you observed in the conversation (including any video analysis). Use ONLY drill IDs from this catalog:
        \(drillCatalog)

        Each recommended drill needs:
        - "drillID": exact ID from the catalog above
        - "reason": 1 sentence explaining WHY this drill helps THIS user specifically (reference their actual swing issues, not generic advice)
        - "priority": "high", "medium", or "low"

        Recommend 3-6 drills total. Prioritize drills that directly address the user's biggest issues.

        For "sessionRecord", summarize THIS session as a single coaching record:
        - "rootCause": The PRIMARY swing fault or issue discussed (one phrase, e.g. "early extension", "weak grip", "over-the-top path"). Pick the most important one.
        - "assignedDrill": The name of the PRIMARY drill you recommended. Use the drill name, not ID.
        - "overallScore": Rate the golfer's current overall swing quality 1-10. 1 = severe issues, 5 = average amateur, 7 = solid ball striker, 10 = tour quality.

        \(hasVideo ? "This conversation includes VIDEO ANALYSIS. You can add, change, or REMOVE drills and issues based on what you see. If the user has fixed a previous issue, remove it and its drills." : "This is a TEXT-ONLY conversation. You may ADD new drills and issues, but keep all existing recommendedDrills from the current profile — do NOT remove any existing drills unless the user explicitly says they've fixed the issue.")

        Respond with ONLY valid JSON (no markdown, no explanation):
        {
            "summary": "Overall assessment paragraph",
            "identifiedIssues": ["issue1", "issue2"],
            "prioritizedIssues": [{"name": "issue1", "priority": "high"}],
            "recommendedDrills": [{"drillID": "drill_id", "reason": "Why this helps you specifically", "priority": "high"}],
            "strengths": ["strength1"],
            "currentFocusAreas": ["focus1"],
            "progressNotes": [{"note": "Session summary"}],
            "sessionRecord": {"rootCause": "primary fault", "assignedDrill": "drill name", "overallScore": 7}
        }
        """

        let userMessage = """
        Current profile:
        \(currentProfileJSON)

        Conversation:
        \(conversationSummary)

        Update the profile JSON based on this conversation.
        """

        do {
            let response = try await ClaudeAPIService.sendSimpleMessage(
                systemPrompt: systemPrompt,
                userMessage: userMessage,
                maxTokens: 4096
            )

            debugLog("Got response (\(response.count) chars): \(response.prefix(300))")

            // Extract JSON from response — handle markdown fences, extra text, etc.
            let json: [String: Any]
            if let parsed = extractJSON(from: response) {
                json = parsed
            } else {
                debugLog("Failed to parse JSON from response")
                return
            }

            debugLog("Parsed JSON keys: \(json.keys.sorted())")

            // Merge updates on MainActor so @Observable triggers UI refresh
            await MainActor.run {
                if let summary = json["summary"] as? String, !summary.isEmpty {
                    swingProfile.summary = summary
                }
                if let issues = json["identifiedIssues"] as? [String] {
                    let merged = Set(swingProfile.identifiedIssues).union(Set(issues))
                    swingProfile.identifiedIssues = Array(merged)
                }
                if let prioritized = json["prioritizedIssues"] as? [[String: Any]] {
                    var newPrioritized: [PrioritizedIssue] = []
                    for item in prioritized {
                        if let name = item["name"] as? String,
                           let priorityStr = item["priority"] as? String,
                           let priority = PrioritizedIssue.IssuePriority(rawValue: priorityStr) {
                            newPrioritized.append(PrioritizedIssue(name: name, priority: priority))
                        }
                    }
                    if !newPrioritized.isEmpty {
                        swingProfile.prioritizedIssues = newPrioritized
                        debugLog("Updated \(newPrioritized.count) prioritized issues")
                    }
                }
                if let drills = json["recommendedDrills"] as? [[String: Any]] {
                    let validDrillIDs = Set(DrillData.all.map(\.id))
                    var newDrills: [RecommendedDrill] = []
                    for item in drills {
                        if let drillID = item["drillID"] as? String,
                           validDrillIDs.contains(drillID),
                           let reason = item["reason"] as? String,
                           let priorityStr = item["priority"] as? String,
                           let priority = PrioritizedIssue.IssuePriority(rawValue: priorityStr) {
                            newDrills.append(RecommendedDrill(drillID: drillID, reason: reason, priority: priority))
                        }
                    }
                    if !newDrills.isEmpty {
                        if hasVideo {
                            // Video analysis: full replace — AI can remove drills for fixed issues
                            swingProfile.recommendedDrills = newDrills
                            debugLog("Replaced drills from video analysis: \(newDrills.count)")
                        } else {
                            // Text only: merge — keep existing, add new ones
                            let existingIDs = Set(swingProfile.recommendedDrills.map(\.drillID))
                            let additions = newDrills.filter { !existingIDs.contains($0.drillID) }
                            swingProfile.recommendedDrills.append(contentsOf: additions)
                            debugLog("Merged drills: kept \(existingIDs.count), added \(additions.count)")
                        }
                    }
                }
                if let strengths = json["strengths"] as? [String] {
                    let merged = Set(swingProfile.strengths).union(Set(strengths))
                    swingProfile.strengths = Array(merged)
                }
                if let focus = json["currentFocusAreas"] as? [String], !focus.isEmpty {
                    swingProfile.currentFocusAreas = focus
                }
                if let notes = json["progressNotes"] as? [[String: Any]] {
                    for noteDict in notes {
                        if let noteText = noteDict["note"] as? String {
                            swingProfile.progressNotes.append(ProgressNote(note: noteText))
                        }
                    }
                }

                // Parse session record and append to history
                if let record = json["sessionRecord"] as? [String: Any] {
                    let rootCause = record["rootCause"] as? String ?? ""
                    let assignedDrill = record["assignedDrill"] as? String ?? ""
                    let overallScore = (record["overallScore"] as? Int) ?? (Int(record["overallScore"] as? String ?? "") ?? 5)

                    if !rootCause.isEmpty {
                        let sessionRecord = SessionRecord(
                            rootCause: rootCause,
                            assignedDrill: assignedDrill,
                            overallScore: overallScore
                        )
                        swingProfile.sessionHistory.append(sessionRecord)
                        if swingProfile.sessionHistory.count > 10 {
                            swingProfile.sessionHistory = Array(swingProfile.sessionHistory.suffix(10))
                        }
                        debugLog("Added session record: root=\(rootCause), drill=\(assignedDrill), score=\(overallScore)")
                    }
                }

                debugLog("Profile updated — issues: \(self.swingProfile.identifiedIssues.count), prioritized: \(self.swingProfile.prioritizedIssues.count), strengths: \(self.swingProfile.strengths.count)")
                self.save()
            }
        } catch {
            debugLog("Profile update failed: \(error.localizedDescription)")
        }
    }

    func clearProfile() {
        swingProfile = .empty
        save()
    }

    private func save() {
        UserDefaultsManager.saveSwingProfile(swingProfile)
    }

    /// Extract a JSON dictionary from a response that might contain markdown fences or extra text
    private func extractJSON(from response: String) -> [String: Any]? {
        // First try: direct parse after cleaning markdown fences
        let cleaned = response
            .replacingOccurrences(of: "```json", with: "")
            .replacingOccurrences(of: "```", with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)

        if let data = cleaned.data(using: .utf8),
           let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
            return json
        }

        // Second try: find the outermost { } braces
        guard let start = cleaned.firstIndex(of: "{"),
              let end = cleaned.lastIndex(of: "}")
        else { return nil }

        let jsonSubstring = String(cleaned[start...end])
        if let data = jsonSubstring.data(using: .utf8),
           let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
            return json
        }

        return nil
    }

    private func debugLog(_ message: String) {
        let logFile = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("swing_memory_debug.log")
        let timestamp = ISO8601DateFormatter().string(from: Date())
        let line = "[\(timestamp)] \(message)\n"
        if let data = line.data(using: .utf8) {
            if FileManager.default.fileExists(atPath: logFile.path) {
                if let handle = try? FileHandle(forWritingTo: logFile) {
                    handle.seekToEndOfFile()
                    handle.write(data)
                    handle.closeFile()
                }
            } else {
                try? data.write(to: logFile)
            }
        }
    }
}
