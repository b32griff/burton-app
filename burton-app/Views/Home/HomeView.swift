import SwiftUI

struct HomeView: View {
    @Environment(AppState.self) private var appState
    @Environment(SwingMemoryManager.self) private var memoryManager
    @Environment(SubscriptionManager.self) private var subscriptionManager
    @Environment(\.selectedTab) private var selectedTab
    @State private var showSettings = false
    @State private var showVideoTips = false
    @State private var showPaywall = false
    @State private var showSwingProfile = false

    private var profile: SwingProfile { memoryManager.swingProfile }
    private var drills: [RecommendedDrill] { profile.recommendedDrills }

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                header
                    .padding(.bottom, 20)

                swingProfileSection
                    .padding(.bottom, 24)

                drillsSection
                    .padding(.bottom, 24)

                recentChatsSection
                    .padding(.bottom, 24)

                videoAngleTipSection
                    .padding(.bottom, 24)

                dailyTipSection
                    .padding(.bottom, 24)

                // -- Pro Upgrade --
                if !subscriptionManager.isSubscribed && subscriptionManager.hasCheckedStatus {
                    freeUserStatusCard
                        .padding(.bottom, 24)
                }

                Spacer().frame(height: 8)
            }
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    Haptics.light()
                    showSettings = true
                } label: {
                    Image(systemName: "gearshape")
                }
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    Haptics.light()
                    showVideoTips = true
                } label: {
                    Image(systemName: "info.circle")
                }
            }
        }
        .sheet(isPresented: $showSettings) {
            SettingsSheet()
        }
        .sheet(isPresented: $showVideoTips) {
            VideoTipsSheet()
        }
        .sheet(isPresented: $showPaywall) {
            PaywallView(showCloseButton: true)
        }
        .sheet(isPresented: $showSwingProfile) {
            SwingProfileSheet()
        }
    }

    // MARK: - Header

    private var greeting: String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 0..<12: return "Good morning"
        case 12..<17: return "Good afternoon"
        default: return "Good evening"
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(appState.userProfile.name.isEmpty
                 ? greeting
                 : "\(greeting), \(appState.userProfile.name)")
                .font(.title2.bold())

            let formatter = DateFormatter()
            let _ = formatter.dateFormat = "EEEE, MMMM d"
            Text(formatter.string(from: Date()))
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
        .padding(.top, 8)
    }

    // MARK: - Daily Tip

    private var dailyTip: Tip? {
        let tips = TipData.all
        guard !tips.isEmpty else { return nil }
        // Days since era start — unique per calendar day, resets at midnight
        let day = Calendar.current.ordinality(of: .day, in: .era, for: Date()) ?? 0
        // Knuth multiplicative hash for pseudo-random distribution
        let hash = day &* 2_654_435_761
        let index = abs(hash % tips.count)
        return tips[index]
    }

    @ViewBuilder
    private var dailyTipSection: some View {
        if let tip = dailyTip {
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 8) {
                    Image(systemName: "lightbulb.fill")
                        .font(.caption)
                        .foregroundStyle(.orange)
                    Text("Tip of the Day")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(.secondary)
                    Spacer()
                    Text(tip.difficulty.rawValue)
                        .font(.caption2)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(Color(.systemGray5), in: Capsule())
                        .foregroundStyle(.secondary)
                }

                Text(tip.title)
                    .font(.subheadline.weight(.semibold))

                Text(tip.summary)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .padding(14)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(.systemGray6), in: RoundedRectangle(cornerRadius: 14))
            .padding(.horizontal, 20)
        }
    }

    // MARK: - Swing Profile

    private var swingProfileSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            sectionHeader("Swing Profile")

            Button {
                Haptics.light()
                if !subscriptionManager.canAccessSwingMemory {
                    showPaywall = true
                } else {
                    showSwingProfile = true
                }
            } label: {
                VStack(alignment: .leading, spacing: 12) {
                    if !subscriptionManager.canAccessSwingMemory {
                        HStack(spacing: 6) {
                            Image(systemName: "lock.fill")
                                .font(.caption2)
                            Text("Upgrade to Pro to unlock swing memory")
                                .font(.caption)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.caption2)
                                .foregroundStyle(.tertiary)
                        }
                        .foregroundStyle(.secondary)
                    } else if profile.isEmpty {
                        HStack {
                            Text("Upload a swing video to start building your profile")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                            Spacer()
                            Image(systemName: "chevron.right")
                                .font(.caption2)
                                .foregroundStyle(.tertiary)
                        }
                    } else {
                        HStack(spacing: 0) {
                            statBlock(
                                value: "\(profile.identifiedIssues.count)",
                                label: "Issues",
                                color: .orange
                            )
                            dividerLine
                            statBlock(
                                value: "\(profile.strengths.count)",
                                label: "Strengths",
                                color: .green
                            )
                            dividerLine
                            statBlock(
                                value: "\(profile.currentFocusAreas.count)",
                                label: "Focus",
                                color: .appAccent
                            )

                            Spacer()

                            Image(systemName: "chevron.right")
                                .font(.caption2)
                                .foregroundStyle(.tertiary)
                                .padding(.trailing, 4)
                        }
                    }
                }
                .padding(14)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color(.systemGray6), in: RoundedRectangle(cornerRadius: 14))
            }
            .buttonStyle(.plain)
            .padding(.horizontal, 20)
        }
    }

    private func statBlock(value: String, label: String, color: Color) -> some View {
        VStack(spacing: 2) {
            Text(value)
                .font(.title3.bold())
                .foregroundStyle(color)
            Text(label)
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
    }

    private var dividerLine: some View {
        Rectangle()
            .fill(Color(.systemGray4))
            .frame(width: 1, height: 28)
    }

    // MARK: - Drills

    private var drillsSection: some View {
        let topDrills = Array(drills.prefix(5))
        let drillMap = Dictionary(uniqueKeysWithValues: DrillData.all.map { ($0.id, $0) })

        return VStack(alignment: .leading, spacing: 10) {
            HStack {
                sectionHeader("Your Drills")
                Spacer()
                Button {
                    Haptics.light()
                    selectedTab.wrappedValue = .drills
                } label: {
                    Text("See All")
                        .font(.caption.weight(.medium))
                        .foregroundStyle(.appAccent)
                }
                .buttonStyle(.plain)
                .padding(.trailing, 20)
            }

            if topDrills.isEmpty {
                Button { Haptics.light(); selectedTab.wrappedValue = .caddie } label: {
                    HStack(spacing: 12) {
                        Image(systemName: "video.badge.plus")
                            .font(.title3)
                            .foregroundStyle(.appAccent)
                        Text("Upload a video for personalized drills")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .font(.caption2)
                            .foregroundStyle(.tertiary)
                    }
                    .padding(14)
                    .background(Color(.systemGray6), in: RoundedRectangle(cornerRadius: 14))
                }
                .buttonStyle(.plain)
                .padding(.horizontal, 20)
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(topDrills) { rec in
                            if let drill = drillMap[rec.drillID] {
                                Button { Haptics.light(); selectedTab.wrappedValue = .drills } label: {
                                    drillScrollCard(drill: drill, priority: rec.priority)
                                }
                                .buttonStyle(.plain)
                            }
                        }

                        // "Browse all" as the last card in the scroll
                        NavigationLink(destination: AllDrillsView()) {
                            VStack(spacing: 8) {
                                Image(systemName: "square.grid.2x2")
                                    .font(.title3)
                                    .foregroundStyle(.appAccent)
                                Text("All Drills")
                                    .font(.caption.weight(.semibold))
                                    .foregroundStyle(.primary)
                            }
                            .frame(width: 90, height: 90)
                            .background(Color(.systemGray6), in: RoundedRectangle(cornerRadius: 14))
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(.horizontal, 20)
                }
            }
        }
    }

    private func drillScrollCard(drill: Drill, priority: PrioritizedIssue.IssuePriority) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack(spacing: 5) {
                Circle()
                    .fill(priorityColor(priority))
                    .frame(width: 7, height: 7)
                Text(drill.category.rawValue)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }

            Text(drill.name)
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.primary)
                .lineLimit(2)
                .multilineTextAlignment(.leading)

            Spacer(minLength: 0)

            Text("\(drill.durationMinutes) min")
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .padding(12)
        .frame(width: 150, height: 100, alignment: .leading)
        .background(Color(.systemGray6), in: RoundedRectangle(cornerRadius: 14))
    }

    // MARK: - Recent Chats

    private var recentChatsSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            sectionHeader("Recent Chats")

            let recentConvos = appState.conversations.filter { $0.title != "New Conversation" }

            if recentConvos.isEmpty {
                Text("No conversations yet")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 20)
            } else {
                VStack(spacing: 0) {
                    ForEach(Array(recentConvos.prefix(3).enumerated()), id: \.element.id) { index, convo in
                        Button {
                            Haptics.light()
                            selectedTab.wrappedValue = .caddie
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                NotificationCenter.default.post(name: .loadConversation, object: convo)
                            }
                        } label: {
                            HStack {
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(convo.title)
                                        .font(.subheadline)
                                        .foregroundStyle(.primary)
                                        .lineLimit(1)
                                    Text(convo.updatedAt.relativeFormatted)
                                        .font(.caption2)
                                        .foregroundStyle(.secondary)
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.caption2)
                                    .foregroundStyle(.tertiary)
                            }
                            .padding(.horizontal, 14)
                            .padding(.vertical, 10)
                        }
                        .buttonStyle(.plain)

                        if index < min(recentConvos.count, 3) - 1 {
                            Divider().padding(.horizontal, 14)
                        }
                    }
                }
                .background(Color(.systemGray6), in: RoundedRectangle(cornerRadius: 14))
                .padding(.horizontal, 20)
            }
        }
    }

    // MARK: - Video Angle Tip

    private var videoAngleTipSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            sectionHeader("Get Better Feedback")

            Button {
                Haptics.light()
                showVideoTips = true
            } label: {
                HStack(spacing: 14) {
                    Image(systemName: "video.badge.checkmark")
                        .font(.title3)
                        .foregroundStyle(.appAccent)

                    VStack(alignment: .leading, spacing: 2) {
                        Text("How to Film Your Swing")
                            .font(.subheadline.weight(.semibold))
                            .foregroundStyle(.primary)
                        Text("Camera angles, lighting, what to say — everything that helps Caddie give you better feedback")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }

                    Spacer()

                    Image(systemName: "chevron.right")
                        .font(.caption2)
                        .foregroundStyle(.tertiary)
                }
                .padding(14)
                .background(Color(.systemGray6), in: RoundedRectangle(cornerRadius: 14))
            }
            .buttonStyle(.plain)
            .padding(.horizontal, 20)
        }
    }

    // MARK: - Free User Status Card

    private var freeUserStatusCard: some View {
        Button { Haptics.light(); showPaywall = true } label: {
            HStack(spacing: 14) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Unlock Caddie Pro")
                        .font(.subheadline.bold())
                        .foregroundStyle(.white)
                    Text("\(subscriptionManager.videoAnalysesThisMonth)/\(subscriptionManager.videoAnalysisLimit) free videos used")
                        .font(.caption2)
                        .foregroundStyle(.white.opacity(0.7))

                    // Usage bar
                    GeometryReader { geo in
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 3)
                                .fill(.white.opacity(0.2))
                                .frame(height: 5)
                            RoundedRectangle(cornerRadius: 3)
                                .fill(.white)
                                .frame(width: geo.size.width * usageFraction, height: 5)
                        }
                    }
                    .frame(height: 5)
                }

                Text("Try Free")
                    .font(.caption.bold())
                    .foregroundStyle(.appAccent)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(.white, in: Capsule())
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                LinearGradient(
                    colors: [Color.appAccent, Color.appAccentDark],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ),
                in: RoundedRectangle(cornerRadius: 14)
            )
        }
        .buttonStyle(.plain)
        .padding(.horizontal, 20)
    }

    private var usageFraction: CGFloat {
        guard subscriptionManager.videoAnalysisLimit > 0 else { return 0 }
        return CGFloat(subscriptionManager.videoAnalysesThisMonth) / CGFloat(subscriptionManager.videoAnalysisLimit)
    }

    // MARK: - Helpers

    private func sectionHeader(_ title: String) -> some View {
        Text(title)
            .font(.subheadline.bold())
            .foregroundStyle(.primary)
            .padding(.horizontal, 20)
    }

    private func priorityColor(_ priority: PrioritizedIssue.IssuePriority) -> Color {
        switch priority {
        case .high: .red
        case .medium: .orange
        case .low: .blue
        }
    }

}

// MARK: - Flow Layout

private struct FlowLayout: Layout {
    var spacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = arrange(proposal: proposal, subviews: subviews)
        return result.size
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = arrange(proposal: proposal, subviews: subviews)
        for (index, subview) in subviews.enumerated() {
            subview.place(at: CGPoint(x: bounds.minX + result.positions[index].x,
                                      y: bounds.minY + result.positions[index].y),
                          proposal: .unspecified)
        }
    }

    private func arrange(proposal: ProposedViewSize, subviews: Subviews) -> (positions: [CGPoint], size: CGSize) {
        let maxWidth = proposal.width ?? .infinity
        var positions: [CGPoint] = []
        var x: CGFloat = 0
        var y: CGFloat = 0
        var rowHeight: CGFloat = 0
        var maxX: CGFloat = 0

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            if x + size.width > maxWidth && x > 0 {
                x = 0
                y += rowHeight + spacing
                rowHeight = 0
            }
            positions.append(CGPoint(x: x, y: y))
            rowHeight = max(rowHeight, size.height)
            x += size.width + spacing
            maxX = max(maxX, x - spacing)
        }

        return (positions, CGSize(width: maxX, height: y + rowHeight))
    }
}

// MARK: - Swing Profile Sheet

struct SwingProfileSheet: View {
    @Environment(SwingMemoryManager.self) private var memoryManager
    @Environment(\.dismiss) private var dismiss

    private var profile: SwingProfile { memoryManager.swingProfile }

    var body: some View {
        NavigationStack {
            ScrollView {
                if profile.isEmpty {
                    emptyState
                } else {
                    profileContent
                }
            }
            .navigationTitle("Your Swing")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") { Haptics.light(); dismiss() }
                }
            }
        }
    }

    private var emptyState: some View {
        VStack(spacing: 20) {
            Spacer().frame(height: 80)

            Image(systemName: "figure.golf")
                .font(.system(size: 50))
                .foregroundStyle(.appAccent)

            Text("No Swing Data Yet")
                .font(.title3.bold())

            Text("Upload a swing video or chat with Caddie about your game. The AI will build a detailed profile of your swing over time.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)

            Spacer()
        }
    }

    private var profileContent: some View {
                VStack(alignment: .leading, spacing: 24) {

                    // Overall verdict
                    if !profile.summary.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("The Verdict")
                                .font(.headline)
                            Text(profile.summary)
                                .font(.body)
                                .foregroundStyle(.primary)
                        }
                        .padding(16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(.systemGray6), in: RoundedRectangle(cornerRadius: 14))
                    }

                    // Issues — the blunt part
                    if !profile.prioritizedIssues.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            HStack(spacing: 8) {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .foregroundStyle(.orange)
                                Text("What's Hurting Your Game")
                                    .font(.headline)
                            }

                            ForEach(profile.prioritizedIssues.sorted { $0.priority.sortOrder < $1.priority.sortOrder }) { issue in
                                HStack(spacing: 12) {
                                    Circle()
                                        .fill(issueColor(issue.priority))
                                        .frame(width: 10, height: 10)

                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(issue.name)
                                            .font(.subheadline.weight(.semibold))
                                        Text(issueLabel(issue.priority))
                                            .font(.caption)
                                            .foregroundStyle(issueColor(issue.priority))
                                    }

                                    Spacer()
                                }
                                .padding(12)
                                .background(Color(.systemGray6), in: RoundedRectangle(cornerRadius: 10))
                            }
                        }
                    } else if !profile.identifiedIssues.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            HStack(spacing: 8) {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .foregroundStyle(.orange)
                                Text("What's Hurting Your Game")
                                    .font(.headline)
                            }

                            ForEach(profile.identifiedIssues, id: \.self) { issue in
                                HStack(spacing: 12) {
                                    Circle()
                                        .fill(.orange)
                                        .frame(width: 10, height: 10)
                                    Text(issue)
                                        .font(.subheadline)
                                }
                                .padding(12)
                                .background(Color(.systemGray6), in: RoundedRectangle(cornerRadius: 10))
                            }
                        }
                    }

                    // Strengths
                    if !profile.strengths.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            HStack(spacing: 8) {
                                Image(systemName: "checkmark.seal.fill")
                                    .foregroundStyle(.green)
                                Text("What's Working")
                                    .font(.headline)
                            }

                            ForEach(profile.strengths, id: \.self) { strength in
                                HStack(spacing: 12) {
                                    Image(systemName: "checkmark")
                                        .font(.caption.bold())
                                        .foregroundStyle(.green)
                                    Text(strength)
                                        .font(.subheadline)
                                }
                                .padding(12)
                                .background(Color(.systemGray6), in: RoundedRectangle(cornerRadius: 10))
                            }
                        }
                    }

                    // Focus areas
                    if !profile.currentFocusAreas.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            HStack(spacing: 8) {
                                Image(systemName: "target")
                                    .foregroundStyle(.appAccent)
                                Text("Where to Focus")
                                    .font(.headline)
                            }

                            ForEach(Array(profile.currentFocusAreas.enumerated()), id: \.element) { index, area in
                                HStack(spacing: 12) {
                                    Text("\(index + 1)")
                                        .font(.caption.bold())
                                        .foregroundStyle(.white)
                                        .frame(width: 22, height: 22)
                                        .background(Color.appAccent, in: Circle())
                                    Text(area)
                                        .font(.subheadline)
                                }
                                .padding(12)
                                .background(Color(.systemGray6), in: RoundedRectangle(cornerRadius: 10))
                            }
                        }
                    }

                    // Session history
                    if !profile.sessionHistory.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            HStack(spacing: 8) {
                                Image(systemName: "clock.arrow.circlepath")
                                    .foregroundStyle(.secondary)
                                Text("Session History")
                                    .font(.headline)
                            }

                            ForEach(profile.sessionHistory.suffix(5).reversed()) { session in
                                VStack(alignment: .leading, spacing: 8) {
                                    HStack {
                                        Text(session.date, style: .date)
                                            .font(.caption)
                                            .foregroundStyle(.secondary)
                                        Spacer()
                                        scoreIndicator(session.overallScore)
                                    }

                                    if !session.rootCause.isEmpty {
                                        HStack(spacing: 6) {
                                            Text("Worked on:")
                                                .font(.caption)
                                                .foregroundStyle(.secondary)
                                            Text(session.rootCause)
                                                .font(.caption.weight(.medium))
                                        }
                                    }

                                    if !session.assignedDrill.isEmpty {
                                        HStack(spacing: 6) {
                                            Text("Drill:")
                                                .font(.caption)
                                                .foregroundStyle(.secondary)
                                            Text(session.assignedDrill)
                                                .font(.caption.weight(.medium))
                                        }
                                    }
                                }
                                .padding(12)
                                .background(Color(.systemGray6), in: RoundedRectangle(cornerRadius: 10))
                            }
                        }
                    }

                    // Progress notes
                    if !profile.progressNotes.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            HStack(spacing: 8) {
                                Image(systemName: "note.text")
                                    .foregroundStyle(.secondary)
                                Text("Progress Notes")
                                    .font(.headline)
                            }

                            ForEach(profile.progressNotes.suffix(5).reversed()) { note in
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(note.date, style: .date)
                                        .font(.caption2)
                                        .foregroundStyle(.secondary)
                                    Text(note.note)
                                        .font(.subheadline)
                                }
                                .padding(12)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(Color(.systemGray6), in: RoundedRectangle(cornerRadius: 10))
                            }
                        }
                    }

                    Spacer().frame(height: 20)
                }
                .padding(.horizontal, 20)
    }

    // MARK: - Helpers

    private func issueColor(_ priority: PrioritizedIssue.IssuePriority) -> Color {
        switch priority {
        case .high: .red
        case .medium: .orange
        case .low: .blue
        }
    }

    private func issueLabel(_ priority: PrioritizedIssue.IssuePriority) -> String {
        switch priority {
        case .high: "Fix this first"
        case .medium: "Needs work"
        case .low: "Minor issue"
        }
    }

    private func scoreIndicator(_ score: Int) -> some View {
        HStack(spacing: 2) {
            Text("\(score)")
                .font(.caption.bold())
                .foregroundStyle(scoreColor(score))
            Text("/10")
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 3)
        .background(scoreColor(score).opacity(0.12), in: Capsule())
    }

    private func scoreColor(_ score: Int) -> Color {
        switch score {
        case 8...10: .green
        case 5...7: .orange
        default: .red
        }
    }
}

// MARK: - Video Tips Sheet

struct VideoTipsSheet: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {

                    // Hero
                    VStack(spacing: 8) {
                        Image(systemName: "video.badge.checkmark")
                            .font(.system(size: 40))
                            .foregroundStyle(.blue)
                        Text("Record the Perfect Swing Video")
                            .font(.title3.bold())
                            .multilineTextAlignment(.center)
                        Text("Better video = better analysis. Follow these tips to get the most out of Caddie AI.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 8)

                    // Recording Tips
                    tipSection(title: "Recording", tips: [
                        VideoTip(
                            icon: "arrow.triangle.2.circlepath.camera",
                            title: "Film Down the Line",
                            detail: "Stand directly behind the golfer, camera pointing at the target. This is the best angle for seeing swing path, plane, and body rotation."
                        ),
                        VideoTip(
                            icon: "hand.point.down",
                            title: "Camera at Hand Height",
                            detail: "Prop your phone on a bag or use a tripod at waist/hand height. Too high or too low distorts body angles."
                        ),
                        VideoTip(
                            icon: "slowmo",
                            title: "Use Slow Motion",
                            detail: "iPhone slo-mo (240fps) captures dramatically more detail. Open Camera, swipe to \"Slo-Mo\", then record."
                        ),
                        VideoTip(
                            icon: "person.fill",
                            title: "Full Body in Frame",
                            detail: "Head to feet with room on all sides. Make sure the club isn't cut off at the top of the backswing."
                        ),
                        VideoTip(
                            icon: "sun.max.fill",
                            title: "Good Lighting",
                            detail: "Face the sun — don't film toward it. Backlit videos create silhouettes the AI can't analyze."
                        ),
                        VideoTip(
                            icon: "1.circle",
                            title: "One Swing Per Video",
                            detail: "Record a single swing. Start filming before your setup and keep rolling through the finish."
                        ),
                        VideoTip(
                            icon: "person.crop.circle.badge.exclamationmark",
                            title: "Your Swing Only",
                            detail: "Only send videos of your own swing. Submitting a friend's or someone else's swing will confuse your swing profile and progress tracking."
                        ),
                    ])

                    // Message Tips
                    tipSection(title: "In Your Message", tips: [
                        VideoTip(
                            icon: "target",
                            title: "Describe Your Miss",
                            detail: "\"I'm hitting a pull-hook\" or \"I keep chunking it\" gives the AI critical context the video alone can't show."
                        ),
                        VideoTip(
                            icon: "wrench.and.screwdriver",
                            title: "Say What You're Working On",
                            detail: "\"I've been trying to shallow the club\" helps Caddie tailor the fix to your current focus."
                        ),
                        VideoTip(
                            icon: "location.circle",
                            title: "Mention the Situation",
                            detail: "\"On the course right now\" vs. \"at the range\" changes the advice. On-course = one quick thought. Range = drill work."
                        ),
                    ])

                    // Quick Checklist
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Quick Checklist")
                            .font(.subheadline.bold())

                        VStack(alignment: .leading, spacing: 8) {
                            checklistItem("Down-the-line angle")
                            checklistItem("Camera at hand/hip height")
                            checklistItem("Slow motion enabled")
                            checklistItem("Full body visible")
                            checklistItem("Good lighting (not backlit)")
                            checklistItem("Select the correct club")
                            checklistItem("Your swing only — not a friend's")
                            checklistItem("Describe your miss in the message")
                        }
                    }
                    .padding(16)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(.systemGray6), in: RoundedRectangle(cornerRadius: 14))

                    Spacer().frame(height: 20)
                }
                .padding(.horizontal, 20)
            }
            .navigationTitle("Video Tips")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") { Haptics.light(); dismiss() }
                }
            }
        }
    }

    private func tipSection(title: String, tips: [VideoTip]) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.subheadline.bold())

            VStack(spacing: 0) {
                ForEach(Array(tips.enumerated()), id: \.element.icon) { index, tip in
                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: tip.icon)
                            .font(.system(size: 18))
                            .foregroundStyle(.blue)
                            .frame(width: 28, height: 28, alignment: .center)

                        VStack(alignment: .leading, spacing: 2) {
                            Text(tip.title)
                                .font(.subheadline.weight(.semibold))
                            Text(tip.detail)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 14)

                    if index < tips.count - 1 {
                        Divider().padding(.leading, 54)
                    }
                }
            }
            .background(Color(.systemGray6), in: RoundedRectangle(cornerRadius: 14))
        }
    }

    private func checklistItem(_ text: String) -> some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark.circle")
                .font(.body)
                .foregroundStyle(.green)
            Text(text)
                .font(.subheadline)
        }
    }
}

private struct VideoTip {
    let icon: String
    let title: String
    let detail: String
}
