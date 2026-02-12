import Foundation

struct SystemPromptBuilder {
    static func build(
        userProfile: UserProfile,
        swingProfile: SwingProfile,
        recentConversationSummaries: [String],
        videoAnalysisMode: Bool = false
    ) -> String {
        var parts: [String] = []

        // Role definition
        parts.append("""
        You are an expert golf swing coach with deep knowledge of swing mechanics, short game, putting, course management, and the mental game. You provide personalized, actionable advice based on the golfer's skill level and goals. Be encouraging but honest. Keep responses concise and focused.
        """)

        // User profile context
        parts.append(buildUserProfileSection(userProfile))

        // Swing memory context
        if !swingProfile.isEmpty {
            parts.append(buildSwingMemorySection(swingProfile))
        }

        // Recent conversation summaries
        if !recentConversationSummaries.isEmpty {
            parts.append(buildRecentSessionsSection(recentConversationSummaries))
        }

        // Knowledge base
        parts.append(buildKnowledgeBase())

        // Behavioral guidelines
        parts.append(buildGuidelines(skillLevel: userProfile.skillLevel))

        // Video analysis mode
        if videoAnalysisMode {
            parts.append(buildVideoAnalysisInstructions())
        }

        return parts.joined(separator: "\n\n")
    }

    private static func buildUserProfileSection(_ profile: UserProfile) -> String {
        var section = "## Current Golfer Profile"
        if !profile.name.isEmpty {
            section += "\nName: \(profile.name)"
        }
        section += "\nSkill Level: \(profile.skillLevel.rawValue) — \(profile.skillLevel.description)"
        if let handicap = profile.handicap {
            section += "\nHandicap: \(handicap)"
        }
        if !profile.goals.isEmpty {
            section += "\nGoals: \(profile.goals.map(\.rawValue).joined(separator: ", "))"
        }
        return section
    }

    private static func buildSwingMemorySection(_ profile: SwingProfile) -> String {
        var section = "## Swing Memory (accumulated from previous sessions)"
        if !profile.summary.isEmpty {
            section += "\nSummary: \(profile.summary)"
        }
        if !profile.identifiedIssues.isEmpty {
            section += "\nKnown Issues: \(profile.identifiedIssues.joined(separator: ", "))"
        }
        if !profile.strengths.isEmpty {
            section += "\nStrengths: \(profile.strengths.joined(separator: ", "))"
        }
        if !profile.currentFocusAreas.isEmpty {
            section += "\nCurrent Focus: \(profile.currentFocusAreas.joined(separator: ", "))"
        }
        let recentNotes = profile.progressNotes.suffix(5)
        if !recentNotes.isEmpty {
            section += "\nRecent Progress:"
            for note in recentNotes {
                section += "\n- [\(note.date.shortFormatted)] \(note.note)"
            }
        }
        return section
    }

    private static func buildRecentSessionsSection(_ summaries: [String]) -> String {
        var section = "## Recent Conversation Summaries"
        for (i, summary) in summaries.enumerated() {
            section += "\n\(i + 1). \(summary)"
        }
        return section
    }

    private static func buildKnowledgeBase() -> String {
        var section = "## Golf Knowledge Base\n"

        section += "\n### Common Swing Issues"
        for issue in SwingIssueData.all {
            section += "\n- **\(issue.name)**: \(issue.description) Causes: \(issue.commonCauses.joined(separator: "; "))"
        }

        section += "\n\n### Tips Library"
        for tip in TipData.all {
            section += "\n- **\(tip.title)** (\(tip.difficulty.rawValue)): \(tip.summary) \(tip.body)"
        }

        section += "\n\n### Drills Library"
        for drill in DrillData.all {
            section += "\n- **\(drill.name)** (\(drill.difficulty.rawValue), \(drill.durationMinutes)min, needs: \(drill.equipment.joined(separator: ", "))): \(drill.instructions.joined(separator: " "))"
        }

        return section
    }

    private static func buildGuidelines(skillLevel: SkillLevel) -> String {
        var section = "## Response Guidelines"
        section += "\n- Keep responses concise (2-4 paragraphs max unless detailed analysis is requested)"
        section += "\n- Use language appropriate for a \(skillLevel.rawValue.lowercased()) golfer"

        switch skillLevel {
        case .beginner:
            section += "\n- Avoid technical jargon; use simple analogies"
            section += "\n- Focus on fundamentals: grip, stance, basic swing"
        case .intermediate:
            section += "\n- Use standard golf terminology"
            section += "\n- Focus on consistency and shot shaping"
        case .advanced, .scratch:
            section += "\n- Use technical terminology freely"
            section += "\n- Focus on fine-tuning, course management, and mental game"
        }

        section += "\n- Always be encouraging and positive"
        section += "\n- When suggesting drills, reference specific drills from the knowledge base by name"
        section += "\n- Ask follow-up questions to better understand the golfer's situation"
        return section
    }

    private static func buildVideoAnalysisInstructions() -> String {
        return """
        ## Video Analysis Mode
        You are analyzing frames extracted from a golf swing video. The frames show key positions in the swing sequence. Analyze:
        1. Setup/Address position (grip, stance, alignment, posture)
        2. Backswing (shoulder turn, hip turn, club position at top)
        3. Downswing (sequence, lag, hip clearance)
        4. Impact (shaft lean, weight position, clubface)
        5. Follow-through (balance, finish position)

        Provide specific, actionable feedback based on what you see. Reference relevant tips and drills from the knowledge base.
        """
    }
}
