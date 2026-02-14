import SwiftUI

struct RecommendedDrillsView: View {
    @Environment(AppState.self) private var appState
    @Environment(SwingMemoryManager.self) private var memoryManager

    var body: some View {
        ScrollView {
            if recommendations.isEmpty {
                emptyState
            } else {
                VStack(spacing: 0) {
                    ForEach(prioritySections, id: \.priority) { section in
                        if !section.items.isEmpty {
                            prioritySection(section)
                        }
                    }
                }
            }
        }
        .navigationTitle("Your Drills")
    }

    // MARK: - Empty State

    private var emptyState: some View {
        VStack(spacing: 20) {
            Spacer().frame(height: 80)

            Image(systemName: "list.bullet.clipboard")
                .font(.system(size: 50))
                .foregroundStyle(.appAccent)

            Text("No Drills Yet")
                .font(.title3.bold())

            Text("Chat with Caddie or upload a swing video. Personalized drills will appear here based on what the AI sees in your swing.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)

            Spacer()
        }
    }

    // MARK: - Priority Section

    private func prioritySection(_ section: PrioritySection) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                Circle()
                    .fill(section.color)
                    .frame(width: 10, height: 10)

                Text(section.title)
                    .font(.headline)
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)

            Text(section.subtitle)
                .font(.caption)
                .foregroundStyle(.secondary)
                .padding(.horizontal, 20)

            LazyVStack(spacing: 0) {
                ForEach(section.items) { item in
                    NavigationLink(destination: DrillDetailView(drill: item.drill)) {
                        DrillCard(drill: item.drill, reason: item.reason, priorityColor: section.color)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.top, 4)
        }
    }

    // MARK: - Data

    struct DrillItem: Identifiable {
        let id: String
        let drill: Drill
        let reason: String
        let priority: PrioritizedIssue.IssuePriority
    }

    struct PrioritySection {
        let priority: String
        let title: String
        let subtitle: String
        let color: Color
        let items: [DrillItem]
    }

    private var recommendations: [DrillItem] {
        let drillMap = Dictionary(uniqueKeysWithValues: DrillData.all.map { ($0.id, $0) })

        return memoryManager.swingProfile.recommendedDrills.compactMap { rec in
            guard let drill = drillMap[rec.drillID] else { return nil }
            return DrillItem(id: rec.drillID, drill: drill, reason: rec.reason, priority: rec.priority)
        }
    }

    private var prioritySections: [PrioritySection] {
        let items = recommendations
        guard !items.isEmpty else { return [] }

        var sections: [PrioritySection] = []

        for level in PrioritizedIssue.IssuePriority.allCases {
            let matching = items.filter { $0.priority == level }
            guard !matching.isEmpty else { continue }

            let config = priorityConfig(for: level)
            sections.append(PrioritySection(
                priority: level.rawValue,
                title: config.title,
                subtitle: config.subtitle,
                color: config.color,
                items: matching
            ))
        }

        return sections
    }

    private func priorityConfig(for priority: PrioritizedIssue.IssuePriority) -> (title: String, subtitle: String, color: Color) {
        switch priority {
        case .high:
            return ("High Priority", "Focus on these first", .red)
        case .medium:
            return ("Medium Priority", "Work on these next", .orange)
        case .low:
            return ("Low Priority", "Keep these in mind", .blue)
        }
    }
}

// MARK: - Drill Card

struct DrillCard: View {
    let drill: Drill
    let reason: String
    var priorityColor: Color = .appAccent

    var body: some View {
        HStack(spacing: 0) {
            RoundedRectangle(cornerRadius: 2)
                .fill(priorityColor)
                .frame(width: 4)
                .padding(.vertical, 8)

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(drill.name)
                        .font(.headline)
                        .foregroundStyle(.primary)
                    Spacer()
                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .foregroundStyle(.tertiary)
                }

                if !reason.isEmpty {
                    Text(reason)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                }

                HStack(spacing: 16) {
                    Label("\(drill.durationMinutes) min", systemImage: "clock")
                    Label(drill.difficulty.rawValue, systemImage: "star")
                    Label(drill.equipment.joined(separator: ", "), systemImage: "sportscourt")
                }
                .font(.caption)
                .foregroundStyle(.tertiary)
            }
            .padding(16)
        }
        .background(Color(.systemGray6), in: RoundedRectangle(cornerRadius: 14))
        .padding(.horizontal, 20)
        .padding(.vertical, 4)
    }
}
