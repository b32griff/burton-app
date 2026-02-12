import SwiftUI

struct RecommendedDrillsView: View {
    @Environment(AppState.self) private var appState
    @Environment(SwingMemoryManager.self) private var memoryManager

    var body: some View {
        ScrollView {
            if recommendedDrills.isEmpty {
                emptyState
            } else {
                VStack(spacing: 0) {
                    // Issues the coach identified
                    if !memoryManager.swingProfile.identifiedIssues.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Your Coach Identified")
                                .font(.caption.weight(.semibold))
                                .foregroundStyle(.secondary)
                                .textCase(.uppercase)

                            FlowLayout(spacing: 8) {
                                ForEach(memoryManager.swingProfile.identifiedIssues, id: \.self) { issue in
                                    Text(issue)
                                        .font(.caption.weight(.medium))
                                        .padding(.horizontal, 12)
                                        .padding(.vertical, 6)
                                        .background(.golfGreen.opacity(0.15), in: Capsule())
                                        .foregroundStyle(.golfGreen)
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 16)
                        .padding(.bottom, 12)
                    }

                    // Recommended drills
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Recommended Drills")
                            .font(.title3.bold())
                            .padding(.horizontal, 20)
                            .padding(.top, 8)

                        Text("Updated automatically as you chat with your coach.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .padding(.horizontal, 20)

                        LazyVStack(spacing: 0) {
                            ForEach(recommendedDrills) { drill in
                                NavigationLink(destination: DrillDetailView(drill: drill)) {
                                    DrillCard(drill: drill, issue: matchingIssue(for: drill))
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(.top, 4)
                    }
                }
            }
        }
        .navigationTitle("Drills")
    }

    // MARK: - Empty State

    private var emptyState: some View {
        VStack(spacing: 20) {
            Spacer().frame(height: 80)

            Image(systemName: "list.bullet.clipboard")
                .font(.system(size: 50))
                .foregroundStyle(.golfGreen)

            Text("No Drills Yet")
                .font(.title3.bold())

            Text("Start chatting with your coach about your swing — upload videos, ask questions, describe what's going wrong. Your personalized drills will show up here automatically.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)

            Spacer()
        }
    }

    // MARK: - Drill Matching

    private var recommendedDrills: [Drill] {
        let issues = memoryManager.swingProfile.identifiedIssues
        let focusAreas = memoryManager.swingProfile.currentFocusAreas

        guard !issues.isEmpty || !focusAreas.isEmpty else { return [] }

        let allTerms = issues + focusAreas

        let matchingIssues = SwingIssueData.all.filter { issue in
            let issueName = issue.name.lowercased()
            return allTerms.contains { term in
                let t = term.lowercased()
                return issueName == t
                    || issueName.contains(t)
                    || t.contains(issueName)
                    || keywordsOverlap(issueName, t)
            }
        }

        let drillIDs = Set(matchingIssues.flatMap(\.linkedDrillIDs))
        return DrillData.all.filter { drillIDs.contains($0.id) }
    }

    private func matchingIssue(for drill: Drill) -> String? {
        let allTerms = memoryManager.swingProfile.identifiedIssues + memoryManager.swingProfile.currentFocusAreas

        let match = SwingIssueData.all.first { issue in
            guard issue.linkedDrillIDs.contains(drill.id) else { return false }
            let issueName = issue.name.lowercased()
            return allTerms.contains { term in
                let t = term.lowercased()
                return issueName == t
                    || issueName.contains(t)
                    || t.contains(issueName)
                    || keywordsOverlap(issueName, t)
            }
        }

        return match?.name
    }

    private func keywordsOverlap(_ a: String, _ b: String) -> Bool {
        let stopWords: Set<String> = ["the", "a", "an", "my", "i", "and", "or", "of", "to", "is", "in", "it"]
        let wordsA = Set(a.split(separator: " ").map(String.init)).subtracting(stopWords)
        let wordsB = Set(b.split(separator: " ").map(String.init)).subtracting(stopWords)
        return !wordsA.intersection(wordsB).isEmpty
    }
}

// MARK: - Drill Card

struct DrillCard: View {
    let drill: Drill
    let issue: String?

    var body: some View {
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

            if let issue {
                Text("For: \(issue)")
                    .font(.caption.weight(.medium))
                    .foregroundStyle(.golfGreen)
            }

            HStack(spacing: 16) {
                Label("\(drill.durationMinutes) min", systemImage: "clock")
                Label(drill.difficulty.rawValue, systemImage: "star")
                Label(drill.equipment.first ?? "None", systemImage: "sportscourt")
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
        .padding(16)
        .background(Color(.systemGray6), in: RoundedRectangle(cornerRadius: 14))
        .padding(.horizontal, 20)
        .padding(.vertical, 4)
    }
}

// MARK: - Flow Layout for tags

struct FlowLayout: Layout {
    var spacing: CGFloat = 8

    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = layout(proposal: proposal, subviews: subviews)
        return result.size
    }

    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = layout(proposal: proposal, subviews: subviews)
        for (index, position) in result.positions.enumerated() {
            subviews[index].place(
                at: CGPoint(x: bounds.minX + position.x, y: bounds.minY + position.y),
                proposal: ProposedViewSize(result.sizes[index])
            )
        }
    }

    private func layout(proposal: ProposedViewSize, subviews: Subviews) -> LayoutResult {
        let maxWidth = proposal.width ?? .infinity
        var positions: [CGPoint] = []
        var sizes: [CGSize] = []
        var x: CGFloat = 0
        var y: CGFloat = 0
        var rowHeight: CGFloat = 0

        for subview in subviews {
            let size = subview.sizeThatFits(.unspecified)
            sizes.append(size)

            if x + size.width > maxWidth, x > 0 {
                x = 0
                y += rowHeight + spacing
                rowHeight = 0
            }

            positions.append(CGPoint(x: x, y: y))
            rowHeight = max(rowHeight, size.height)
            x += size.width + spacing
        }

        return LayoutResult(
            size: CGSize(width: maxWidth, height: y + rowHeight),
            positions: positions,
            sizes: sizes
        )
    }

    struct LayoutResult {
        var size: CGSize
        var positions: [CGPoint]
        var sizes: [CGSize]
    }
}
