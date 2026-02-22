import SwiftUI

struct AllDrillsView: View {
    @Environment(SubscriptionManager.self) private var subscriptionManager
    @State private var selectedDifficulty: Difficulty = .beginner
    @State private var showPaywall = false

    private let allDrills = DrillData.all

    var body: some View {
        VStack(spacing: 0) {
            // Difficulty picker
            Picker("Difficulty", selection: $selectedDifficulty) {
                ForEach(Difficulty.allCases) { level in
                    Text(level.rawValue).tag(level)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, 20)
            .padding(.vertical, 12)

            // Drill count
            HStack {
                Text("\(drillsForLevel.count) drills")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Spacer()
                if isLocked {
                    HStack(spacing: 4) {
                        Image(systemName: "lock.fill")
                            .font(.caption2)
                        Text("Pro")
                            .font(.caption.bold())
                    }
                    .foregroundStyle(.secondary)
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 8)

            ScrollView {
                LazyVStack(spacing: 0) {
                    ForEach(groupedByCategory, id: \.category) { group in
                        Section {
                            ForEach(group.drills) { drill in
                                if isLocked {
                                    Button {
                                        Haptics.light()
                                        showPaywall = true
                                    } label: {
                                        drillRow(drill)
                                            .opacity(0.5)
                                            .overlay(alignment: .trailing) {
                                                Image(systemName: "lock.fill")
                                                    .font(.caption)
                                                    .foregroundStyle(.secondary)
                                                    .padding(.trailing, 20)
                                            }
                                    }
                                    .buttonStyle(.plain)
                                } else {
                                    NavigationLink(destination: DrillDetailView(drill: drill)) {
                                        drillRow(drill)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        } header: {
                            HStack(spacing: 8) {
                                Image(systemName: group.category.icon)
                                    .font(.subheadline)
                                    .foregroundStyle(.appAccent)
                                Text(group.category.rawValue)
                                    .font(.subheadline.bold())
                                Spacer()
                                Text("\(group.drills.count)")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            .padding(.horizontal, 20)
                            .padding(.top, 20)
                            .padding(.bottom, 8)
                        }
                    }

                    Spacer().frame(height: 20)
                }
            }
        }
        .navigationTitle("All Drills")
        .navigationBarTitleDisplayMode(.large)
        .sheet(isPresented: $showPaywall) {
            PaywallView(showCloseButton: true)
        }
    }

    // MARK: - Row

    private func drillRow(_ drill: Drill) -> some View {
        HStack(spacing: 14) {
            VStack(alignment: .leading, spacing: 4) {
                Text(drill.name)
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.primary)

                HStack(spacing: 12) {
                    Label("\(drill.durationMinutes) min", systemImage: "clock")
                    if !drill.equipment.isEmpty {
                        Label(drill.equipment.first ?? "", systemImage: "sportscourt")
                    }
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.caption2)
                .foregroundStyle(.tertiary)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
    }

    // MARK: - Data

    private var isLocked: Bool {
        !subscriptionManager.canAccessAllDrills && selectedDifficulty != .beginner
    }

    private var drillsForLevel: [Drill] {
        allDrills.filter { $0.difficulty == selectedDifficulty }
    }

    private var groupedByCategory: [(category: SwingCategory, drills: [Drill])] {
        var result: [(category: SwingCategory, drills: [Drill])] = []
        for category in SwingCategory.allCases {
            let drills = drillsForLevel.filter { $0.category == category }
            if !drills.isEmpty {
                result.append((category: category, drills: drills))
            }
        }
        return result
    }
}
