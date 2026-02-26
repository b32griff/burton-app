import Foundation

@Observable
class SwingMemoryManager {
    var swingProfile: SwingProfile
    private var isUpdating = false

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

        // Prevent concurrent updates from corrupting profile data
        guard !isUpdating else {
            debugLog("Skipped — update already in progress")
            return
        }
        isUpdating = true
        defer { isUpdating = false }

        guard conversation.messages.count >= 2 else {
            debugLog("Skipped — not enough messages")
            return
        }

        // Send only last 6 messages at 500 chars each to control token costs
        let conversationSummary = conversation.messages.suffix(6).map { msg in
            "\(msg.role.rawValue): \(msg.content.prefix(500))"
        }.joined(separator: "\n")

        let currentProfileJSON: String
        if let data = try? JSONEncoder().encode(swingProfile),
           let json = String(data: data, encoding: .utf8) {
            currentProfileJSON = json
        } else {
            currentProfileJSON = "{\"summary\":\"\",\"identifiedIssues\":[],\"strengths\":[],\"currentFocusAreas\":[]}"
        }

        let issueNames = SwingIssueData.all.map(\.name)
        let drillIDs = DrillData.all.map(\.id).joined(separator: ", ")

        let systemPrompt = """
        Golf coaching data analyst. Update swing profile JSON from this conversation. Merge new info — don't remove unless corrected.
        Use issue names from: \(issueNames.prefix(15).joined(separator: ", "))
        Priorities: "high" (1-2 max), "medium", "low".
        Recommend 3-6 drills using ONLY IDs from: \(drillIDs)
        Each drill: drillID, reason (1 sentence), priority.
        sessionRecord: rootCause (1 phrase), assignedDrill (name), overallScore (1-10).
        \(hasVideo ? "VIDEO session: may add/remove drills and issues." : "TEXT session: add only, keep existing drills.")
        Respond with ONLY valid JSON:
        {"summary":"","identifiedIssues":[],"prioritizedIssues":[{"name":"","priority":""}],"recommendedDrills":[{"drillID":"","reason":"","priority":""}],"strengths":[],"currentFocusAreas":[],"progressNotes":[{"note":""}],"sessionRecord":{"rootCause":"","assignedDrill":"","overallScore":5}}
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
                maxTokens: 500,
                taskType: "profile"
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
                    let rawScore = (record["overallScore"] as? Int) ?? (Int(record["overallScore"] as? String ?? "") ?? 5)
                    let overallScore = max(1, min(10, rawScore))

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
                    defer { handle.closeFile() }
                    handle.seekToEndOfFile()
                    handle.write(data)
                }
            } else {
                try? data.write(to: logFile)
            }
        }
    }
}
