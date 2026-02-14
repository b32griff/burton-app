import SwiftUI

struct HomeView: View {
    @Environment(AppState.self) private var appState
    @Environment(SwingMemoryManager.self) private var memoryManager
    @Environment(\.selectedTab) private var selectedTab
    @State private var showSettings = false

    private var profile: SwingProfile { memoryManager.swingProfile }
    private var drills: [RecommendedDrill] { profile.recommendedDrills }

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                header
                cardGrid
                if !appState.userProfile.goals.isEmpty {
                    goalsSection
                }
                dailyTipSection
                quickStartSection
                Spacer().frame(height: 16)
            }
            .padding(.top, 4)
        }
        .navigationTitle("Home")
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    showSettings = true
                } label: {
                    Image(systemName: "gearshape")
                }
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    NotificationCenter.default.post(name: .startNewConversation, object: nil)
                    selectedTab.wrappedValue = .caddie
                } label: {
                    Image(systemName: "plus.message")
                }
            }
        }
        .sheet(isPresented: $showSettings) {
            SettingsSheet()
        }
        .navigationDestination(for: Conversation.self) { conversation in
            ChatView(initialConversation: conversation)
        }
    }

    // MARK: - Header

    private var header: some View {
        VStack(spacing: 2) {
            Text(appState.userProfile.name.isEmpty ? "Welcome" : appState.userProfile.name)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            Text(todayTitle)
                .font(.title2.bold())
        }
        .frame(maxWidth: .infinity)
        .padding(.top, 4)
    }

    private var todayTitle: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return "\(formatter.string(from: Date())) Today's Plan"
    }

    // MARK: - Card Grid

    private var cardGrid: some View {
        let topDrills = Array(drills.prefix(3))
        let drillMap = Dictionary(uniqueKeysWithValues: DrillData.all.map { ($0.id, $0) })

        return HStack(alignment: .top, spacing: 12) {
            // Left column — taller cards
            VStack(spacing: 12) {
                Button { selectedTab.wrappedValue = .caddie } label: {
                    swingProfileCard
                }
                .buttonStyle(.plain)

                recentConversationsCard
            }

            // Right column — compact drill cards
            VStack(spacing: 12) {
                if topDrills.isEmpty {
                    Button { selectedTab.wrappedValue = .caddie } label: {
                        coachCard
                    }
                    .buttonStyle(.plain)

                    Button { selectedTab.wrappedValue = .drills } label: {
                        emptyDrillsCard
                    }
                    .buttonStyle(.plain)
                } else {
                    ForEach(topDrills) { rec in
                        if let drill = drillMap[rec.drillID] {
                            Button { selectedTab.wrappedValue = .drills } label: {
                                drillCard(drill: drill, priority: rec.priority)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
            }
        }
        .padding(.horizontal, 20)
    }

    // MARK: - Swing Profile Card

    private var swingProfileCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Swing Profile")
                    .font(.subheadline.bold())
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
            }

            if profile.isEmpty {
                Text("Chat with Caddie to build your swing profile")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            } else {
                HStack(spacing: 16) {
                    statPill(value: profile.identifiedIssues.count, label: "Issues", color: .orange)
                    statPill(value: profile.strengths.count, label: "Strengths", color: .green)
                }

                if !profile.currentFocusAreas.isEmpty {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Focus")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                        ForEach(profile.currentFocusAreas.prefix(2), id: \.self) { area in
                            Text("· \(area)")
                                .font(.caption)
                                .lineLimit(1)
                        }
                    }
                }
            }
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemGray6), in: RoundedRectangle(cornerRadius: 14))
    }

    // MARK: - Recent Conversations Card

    private var recentConversationsCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Recent Chats")
                    .font(.subheadline.bold())
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
            }

            if appState.conversations.isEmpty {
                Text("Start a conversation with Caddie")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            } else {
                ForEach(appState.conversations.prefix(2)) { convo in
                    NavigationLink(value: convo) {
                        HStack(spacing: 8) {
                            Circle()
                                .fill(.blue)
                                .frame(width: 6, height: 6)
                            Text(convo.title)
                                .font(.caption)
                                .foregroundStyle(.primary)
                                .lineLimit(1)
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemGray6), in: RoundedRectangle(cornerRadius: 14))
    }

    // MARK: - Coach Card (when no drills)

    private var coachCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                Image(systemName: "bubble.left.fill")
                    .font(.subheadline)
                    .foregroundStyle(.blue)
                Text("Caddie")
                    .font(.subheadline.bold())
            }

            Text("Ask anything about your game")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemGray6), in: RoundedRectangle(cornerRadius: 14))
    }

    // MARK: - Empty Drills Card

    private var emptyDrillsCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                Image(systemName: "figure.golf")
                    .font(.subheadline)
                    .foregroundStyle(.appAccent)
                Text("Drills")
                    .font(.subheadline.bold())
            }

            Text("Upload a video to get personalized drills")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemGray6), in: RoundedRectangle(cornerRadius: 14))
    }

    // MARK: - Drill Card (compact, like screenshot)

    private func drillCard(drill: Drill, priority: PrioritizedIssue.IssuePriority) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(drill.name)
                    .font(.subheadline.bold())
                    .lineLimit(1)
                Spacer()
                Image(systemName: "chevron.right")
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
            }

            Text("\(drill.durationMinutes) min · \(drill.category.rawValue)")
                .font(.caption2)
                .foregroundStyle(.secondary)

            // Priority bar
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color(.systemGray4))
                        .frame(height: 4)

                    RoundedRectangle(cornerRadius: 2)
                        .fill(priorityColor(priority))
                        .frame(width: geo.size.width * priorityFill(priority), height: 4)
                }
            }
            .frame(height: 4)
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemGray6), in: RoundedRectangle(cornerRadius: 14))
    }

    // MARK: - Goals Section

    private var goalsSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Your Goals")
                .font(.subheadline.bold())

            FlowLayout(spacing: 8) {
                ForEach(appState.userProfile.goals) { goal in
                    Label(goal.rawValue, systemImage: goal.icon)
                        .font(.caption)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 7)
                        .background(Color(.systemGray6), in: Capsule())
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
    }

    // MARK: - Daily Tip

    private var dailyTip: Tip {
        let dayOfYear = Calendar.current.ordinality(of: .day, in: .year, for: Date()) ?? 0
        let tips = TipData.all
        return tips[dayOfYear % tips.count]
    }

    private var dailyTipSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: "lightbulb.fill")
                    .font(.subheadline)
                    .foregroundStyle(.yellow)
                Text("Tip of the Day")
                    .font(.subheadline.bold())
                Spacer()
                Text(dailyTip.difficulty.rawValue)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }

            Text(dailyTip.title)
                .font(.subheadline.weight(.semibold))

            Text(dailyTip.summary)
                .font(.caption)
                .foregroundStyle(.secondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(14)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemGray6), in: RoundedRectangle(cornerRadius: 14))
        .padding(.horizontal, 20)
    }

    // MARK: - Quick Start

    private var quickStartSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Quick Start")
                .font(.subheadline.bold())

            VStack(spacing: 0) {
                quickStartRow(
                    icon: "video.fill",
                    color: .blue,
                    title: "Upload a Swing Video",
                    subtitle: "Get AI-powered analysis"
                ) {
                    selectedTab.wrappedValue = .caddie
                }
                Divider().padding(.leading, 44)
                quickStartRow(
                    icon: "bubble.left.fill",
                    color: .green,
                    title: "Chat with Caddie",
                    subtitle: "Ask about your game"
                ) {
                    selectedTab.wrappedValue = .caddie
                }
                Divider().padding(.leading, 44)
                quickStartRow(
                    icon: "figure.golf",
                    color: .orange,
                    title: "Browse Drills",
                    subtitle: "Practice plans for every skill"
                ) {
                    selectedTab.wrappedValue = .drills
                }
            }
            .background(Color(.systemGray6), in: RoundedRectangle(cornerRadius: 14))
        }
        .padding(.horizontal, 20)
    }

    private func quickStartRow(icon: String, color: Color, title: String, subtitle: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.body)
                    .foregroundStyle(color)
                    .frame(width: 28, height: 28)

                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.subheadline)
                        .foregroundStyle(.primary)
                    Text(subtitle)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
        }
        .buttonStyle(.plain)
    }

    // MARK: - Helpers

    private func statPill(value: Int, label: String, color: Color) -> some View {
        HStack(spacing: 4) {
            Text("\(value)")
                .font(.subheadline.bold())
                .foregroundStyle(color)
            Text(label)
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
    }

    private func priorityColor(_ priority: PrioritizedIssue.IssuePriority) -> Color {
        switch priority {
        case .high: .red
        case .medium: .orange
        case .low: .blue
        }
    }

    private func priorityFill(_ priority: PrioritizedIssue.IssuePriority) -> CGFloat {
        switch priority {
        case .high: 1.0
        case .medium: 0.6
        case .low: 0.3
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
