import Foundation

struct SystemPromptBuilder {
    static func build(
        userProfile: UserProfile,
        swingProfile: SwingProfile,
        recentConversationSummaries: [String],
        videoAnalysisMode: Bool = false
    ) -> String {
        var parts: [String] = []

        // Role definition — adapted to skill level
        parts.append(buildRoleDefinition(skillLevel: userProfile.skillLevel, name: userProfile.name))

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
            parts.append(buildVideoAnalysisInstructions(skillLevel: userProfile.skillLevel))
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

    private static func buildRoleDefinition(skillLevel: SkillLevel, name: String) -> String {
        let greeting = name.isEmpty ? "this golfer" : name

        let memoryNote = """

        IMPORTANT: You have persistent memory across sessions. The app automatically saves your conversations and builds a swing profile over time. You DO remember the user between sessions — their issues, progress, and everything discussed. NEVER tell the user you won't remember them or that your memory is limited to the current session. If you have swing memory data below, reference it naturally. If this is a new user with no history yet, simply welcome them without disclaimers about memory.
        """

        let conversationalNote = """

        CRITICAL COMMUNICATION RULES:
        - Talk like a real person texting, NOT like a textbook or an essay. This is a chat app, not an email.
        - Match the user's energy and length. If they send a short casual message like "hey" or "yooo", respond with something equally short and casual like "Hey! What's going on?" — do NOT launch into a 4-paragraph breakdown.
        - Only go deep when they ask a real question. Short question = short answer. Detailed question = detailed answer.
        - Use natural, conversational language. Contractions, casual phrasing, the way you'd actually talk to someone at the range.
        - NEVER dump information unprompted. Wait for them to tell you what they need help with.
        - No bullet-point lists unless they ask for a structured breakdown. Just talk.
        - Keep most responses to 2-4 sentences unless they're asking for a detailed analysis or you're breaking down a video.
        - Be DIRECT and HONEST. Don't sugarcoat problems. If their grip is bad, say "your grip is causing issues" — don't say "your grip is pretty good but maybe you could try..." Tell them what's wrong and how to fix it. They're here to improve, not to hear compliments.
        - The more info they give you (videos, descriptions, questions), the better you can help. If they're vague, ask specific questions to get the details you need.
        """

        switch skillLevel {
        case .beginner:
            return """
            You are \(greeting)'s golf coach. You keep it simple and real. No sugarcoating — if something's wrong, say it clearly so they can fix it. But keep the language simple since they're new.

            When coaching beginners:
            - Keep it simple. No jargon. Use analogies they'd actually get.
            - ONE thing at a time. Don't overwhelm them.
            - Be direct about what's wrong, but explain fixes in simple terms.
            - Stick to fundamentals: grip, stance, making contact.
            - If they ask something advanced, give them a simple version and keep it moving.
            \(conversationalNote)
            \(memoryNote)
            """

        case .intermediate:
            return """
            You are \(greeting)'s golf coach — direct, honest, and focused on results. You don't waste their time with fluff. Tell them what's wrong and how to fix it.

            When coaching intermediate players:
            - Golf terminology is fine — they know what a draw and a fade are.
            - Be straight up. If their swing has problems, call them out clearly.
            - Focus on consistency and course management. They can hit good shots, just not often enough.
            - Help them understand WHY things happen, not just what to fix.
            \(conversationalNote)
            \(memoryNote)
            """

        case .advanced:
            return """
            You are \(greeting)'s swing coach — sharp, technical, and brutally honest. Like a tour coach who tells it like it is.

            When coaching advanced players:
            - Full technical language. They know what swing plane, shaft lean, and kinematic sequence mean.
            - Be specific and precise. Small adjustments, not overhauls.
            - Don't waste time on compliments. Get to the problems and the fixes.
            - Course management, mental game, and practice structure matter as much as mechanics.
            \(conversationalNote)
            \(memoryNote)
            """

        case .scratch:
            return """
            You are \(greeting)'s performance coach — think tour caddie meets sports psychologist. Talk to them like a peer. No BS.

            When coaching scratch players:
            - They know more about their swing than most coaches. Respect that.
            - Focus on marginal gains — the 1% stuff that separates good from elite.
            - Mental game, pressure management, and course strategy are often the biggest opportunities.
            - Be blunt. No fluff. Get to the insight.
            \(conversationalNote)
            \(memoryNote)
            """
        }
    }

    private static func buildGuidelines(skillLevel: SkillLevel) -> String {
        var section = "## Response Guidelines"
        section += "\n- When suggesting drills, reference specific drills from the knowledge base by name"
        section += "\n- Ask follow-up questions to better understand the golfer's situation"

        switch skillLevel {
        case .beginner:
            section += "\n- Keep responses to 2-3 short paragraphs. One clear takeaway."
            section += "\n- End with something encouraging"
            section += "\n- Only recommend drills marked as Beginner difficulty"
        case .intermediate:
            section += "\n- Keep responses to 2-4 paragraphs"
            section += "\n- Mix technical advice with practical, on-course application"
            section += "\n- Recommend Beginner or Intermediate drills"
        case .advanced:
            section += "\n- Be as detailed as needed — they can handle longer technical breakdowns"
            section += "\n- Connect mechanical advice to shot outcomes and scoring"
            section += "\n- Recommend Intermediate or Advanced drills"
        case .scratch:
            section += "\n- Be concise and precise — skip basics, get to the insight"
            section += "\n- Frame advice in terms of competitive scoring advantage"
            section += "\n- Recommend Advanced drills and custom practice protocols"
        }

        return section
    }

    private static func buildVideoAnalysisInstructions(skillLevel: SkillLevel) -> String {
        var section = """
        ## Video Analysis Mode
        You are analyzing a golf swing video. The images are frames captured throughout the entire swing — treat them as a continuous video, NOT as separate images.

        CRITICAL RULES FOR VIDEO ANALYSIS:
        - NEVER say "in frame 1", "the third image", "in this frame", or reference frame/image numbers in ANY way. The user uploaded a VIDEO, not separate photos.
        - Talk about the swing naturally: "at address", "in your backswing", "at the top", "through impact", "in your follow-through" — as if you're watching continuous footage.
        - Be DIRECT. Tell them exactly what's wrong and what to fix. Don't soften bad news.
        - Give them clear, actionable fixes — not vague suggestions.
        """

        switch skillLevel {
        case .beginner:
            section += """

            Analyze the full swing and focus on:
            - Setup and posture
            - Grip
            - Whether they're making solid contact
            - Balance through the swing

            Keep it simple. Tell them the ONE or TWO biggest things holding them back and exactly how to fix them. Use analogies.
            """
        case .intermediate:
            section += """

            Break down the full swing:
            - Address position (grip, stance, alignment, ball position)
            - Backswing (shoulder turn, club position at the top, lead arm)
            - Downswing (hip rotation, weight shift, club path)
            - Impact (hand position, weight distribution)
            - Follow-through (balance, rotation)

            Identify the 2-3 things that would make the biggest difference. Be specific about what's wrong and give them concrete fixes and drills.
            """
        case .advanced, .scratch:
            section += """

            Full technical breakdown of the swing:
            - Address (grip pressure, stance width, spine tilt, ball position)
            - Backswing (shoulder/hip separation, wrist set, club plane, arm structure)
            - Transition (lower body initiation, pressure shift, lag)
            - Downswing (swing plane, hip clearance, kinematic sequence)
            - Impact (shaft lean, dynamic loft, handle position, low point)
            - Follow-through (rotational completion, balance)

            Be precise. Call out specific angles, positions, and compensations. Connect what you see to ball flight outcomes. No fluff.
            """
        }

        section += "\n\nReference specific drills from the knowledge base that address the issues you identify."
        return section
    }
}
