import SwiftUI

struct DrillDetailView: View {
    @Environment(AppState.self) private var appState
    let drill: Drill
    @State private var showLogSheet = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header
                headerSection

                // Equipment
                if !drill.equipment.isEmpty {
                    equipmentSection
                }

                // Steps
                stepsSection

                // Start Practice Button
                Button {
                    showLogSheet = true
                } label: {
                    Label("Log Practice Session", systemImage: "plus.circle.fill")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.golfGreen, in: RoundedRectangle(cornerRadius: 14))
                        .foregroundStyle(.white)
                }
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle(drill.name)
        .navigationBarTitleDisplayMode(.large)
        .sheet(isPresented: $showLogSheet) {
            NavigationStack {
                LogPracticeSheet(prefilledDrill: drill)
            }
        }
    }

    private var headerSection: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 6) {
                HStack(spacing: 8) {
                    Label(drill.category.rawValue, systemImage: drill.category.icon)
                        .font(.caption.weight(.medium))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(.golfGreen.opacity(0.12), in: Capsule())
                        .foregroundStyle(.golfGreen)

                    Text(drill.difficulty.rawValue)
                        .font(.caption.weight(.medium))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .background(.sandTrap.opacity(0.2), in: Capsule())
                        .foregroundStyle(.brown)
                }

                HStack(spacing: 4) {
                    Image(systemName: "clock")
                    Text("\(drill.durationMinutes) minutes")
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)
            }
        }
    }

    private var equipmentSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            SectionHeader(title: "Equipment Needed")

            VStack(alignment: .leading, spacing: 6) {
                ForEach(drill.equipment, id: \.self) { item in
                    HStack(spacing: 10) {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.subheadline)
                            .foregroundStyle(.golfGreen)
                        Text(item)
                            .font(.subheadline)
                    }
                }
            }
            .padding()
            .background(.background, in: RoundedRectangle(cornerRadius: 12))
        }
    }

    private var stepsSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            SectionHeader(title: "Instructions")

            VStack(alignment: .leading, spacing: 0) {
                ForEach(Array(drill.instructions.enumerated()), id: \.offset) { index, step in
                    HStack(alignment: .top, spacing: 12) {
                        Text("\(index + 1)")
                            .font(.subheadline.weight(.bold))
                            .foregroundStyle(.white)
                            .frame(width: 28, height: 28)
                            .background(.golfGreen, in: Circle())

                        Text(step)
                            .font(.subheadline)
                            .padding(.vertical, 4)
                    }
                    .padding(.vertical, 8)

                    if index < drill.instructions.count - 1 {
                        Divider()
                            .padding(.leading, 40)
                    }
                }
            }
            .padding()
            .background(.background, in: RoundedRectangle(cornerRadius: 12))
        }
    }
}
