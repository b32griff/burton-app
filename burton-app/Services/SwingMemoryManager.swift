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
        if !swingProfile.identifiedIssues.isEmpty {
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

        return parts.joined(separator: "\n")
    }

    func updateProfile(from conversation: Conversation) async {
        guard conversation.messages.count >= 4 else { return }

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

        let systemPrompt = """
        You are a golf coaching data analyst. Given a conversation between a golf coach and student, update the student's swing profile JSON. Merge new information with existing data — don't remove things unless explicitly corrected. Add a progress note summarizing this session.

        IMPORTANT: For "identifiedIssues", you MUST use values from this exact list when applicable: \(issueNames.joined(separator: ", ")). Only add custom issue names if the issue doesn't fit any of these categories. For "currentFocusAreas", also prefer these exact names when relevant.

        Respond with ONLY valid JSON matching this structure (no markdown, no explanation):
        {
            "summary": "Overall assessment paragraph",
            "identifiedIssues": ["issue1", "issue2"],
            "strengths": ["strength1", "strength2"],
            "currentFocusAreas": ["focus1", "focus2"],
            "progressNotes": [{"note": "Session summary note"}]
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
                userMessage: userMessage
            )

            guard let data = response.data(using: .utf8),
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any]
            else { return }

            // Merge updates
            if let summary = json["summary"] as? String, !summary.isEmpty {
                swingProfile.summary = summary
            }
            if let issues = json["identifiedIssues"] as? [String] {
                let merged = Set(swingProfile.identifiedIssues).union(Set(issues))
                swingProfile.identifiedIssues = Array(merged)
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

            save()
        } catch {
            // Profile update is best-effort; don't surface errors
        }
    }

    func clearProfile() {
        swingProfile = .empty
        save()
    }

    private func save() {
        UserDefaultsManager.saveSwingProfile(swingProfile)
    }
}
