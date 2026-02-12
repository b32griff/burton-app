import SwiftUI

struct RecommendedDrillsView: View {
    @Environment(AppState.self) private var appState
    @Environment(SwingMemoryManager.self) private var memoryManager

    var body: some View {
        List {
            if !recommendedDrills.isEmpty {
                Section {
                    Text("Based on your conversations, your coach recommends these drills.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .listRowBackground(Color.clear)
                        .listRowInsets(EdgeInsets())
                        .padding(.bottom, 4)
                }

                Section("For You") {
                    ForEach(recommendedDrills) { drill in
                        NavigationLink(destination: DrillDetailView(drill: drill)) {
                            DrillRow(drill: drill)
                        }
                    }
                }
            }

            if !recommendedDrills.isEmpty {
                Section("All Drills") {
                    ForEach(remainingDrills) { drill in
                        NavigationLink(destination: DrillDetailView(drill: drill)) {
                            DrillRow(drill: drill)
                        }
                    }
                }
            } else {
                Section {
                    VStack(spacing: 16) {
                        Image(systemName: "figure.golf")
                            .font(.system(size: 40))
                            .foregroundStyle(.golfGreen)

                        Text("Chat with your coach first")
                            .font(.headline)

                        Text("As you discuss your game, your coach will recommend specific drills tailored to your swing. In the meantime, browse all available drills below.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .listRowBackground(Color.clear)
                }

                Section("All Drills") {
                    ForEach(DrillData.all) { drill in
                        NavigationLink(destination: DrillDetailView(drill: drill)) {
                            DrillRow(drill: drill)
                        }
                    }
                }
            }
        }
        .navigationTitle("Drills")
    }

    private var recommendedDrills: [Drill] {
        let issues = memoryManager.swingProfile.identifiedIssues
        let focusAreas = memoryManager.swingProfile.currentFocusAreas

        guard !issues.isEmpty || !focusAreas.isEmpty else { return [] }

        let allTerms = issues + focusAreas

        // Find swing issues that match the user's identified issues or focus areas
        let matchingIssues = SwingIssueData.all.filter { issue in
            let issueName = issue.name.lowercased()
            return allTerms.contains { term in
                let t = term.lowercased()
                // Exact match, containment, or keyword overlap
                return issueName == t
                    || issueName.contains(t)
                    || t.contains(issueName)
                    || issueKeywordsOverlap(issueName, t)
            }
        }

        // Collect linked drill IDs
        let drillIDs = Set(matchingIssues.flatMap(\.linkedDrillIDs))

        // Return matching drills
        let drills = DrillData.all.filter { drillIDs.contains($0.id) }
        return Array(drills.prefix(8))
    }

    /// Check if significant words overlap (e.g. "fat shots" matches "hitting fat")
    private func issueKeywordsOverlap(_ a: String, _ b: String) -> Bool {
        let stopWords: Set<String> = ["the", "a", "an", "my", "i", "and", "or", "of", "to", "is", "in", "it"]
        let wordsA = Set(a.split(separator: " ").map(String.init)).subtracting(stopWords)
        let wordsB = Set(b.split(separator: " ").map(String.init)).subtracting(stopWords)
        return !wordsA.intersection(wordsB).isEmpty
    }

    private var remainingDrills: [Drill] {
        let recommendedIDs = Set(recommendedDrills.map(\.id))
        return DrillData.all.filter { !recommendedIDs.contains($0.id) }
    }
}

struct DrillRow: View {
    let drill: Drill

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(drill.name)
                .font(.subheadline.weight(.medium))

            HStack(spacing: 12) {
                Label("\(drill.durationMinutes) min", systemImage: "clock")
                Label(drill.difficulty.rawValue, systemImage: "star")
                Label(drill.category.rawValue, systemImage: drill.category.icon)
            }
            .font(.caption)
            .foregroundStyle(.secondary)
        }
        .padding(.vertical, 2)
    }
}
