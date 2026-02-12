import SwiftUI

struct DrillDetailView: View {
    let drill: Drill

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing: 12) {
                        Label("\(drill.durationMinutes) min", systemImage: "clock")
                        Label(drill.difficulty.rawValue, systemImage: "star")
                        Label(drill.category.rawValue, systemImage: drill.category.icon)
                    }
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                }

                // Equipment
                if !drill.equipment.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Equipment")
                            .font(.headline)

                        ForEach(drill.equipment, id: \.self) { item in
                            Label(item, systemImage: "checkmark.circle")
                                .font(.subheadline)
                        }
                    }
                }

                // Instructions
                VStack(alignment: .leading, spacing: 12) {
                    Text("Instructions")
                        .font(.headline)

                    ForEach(Array(drill.instructions.enumerated()), id: \.offset) { index, step in
                        HStack(alignment: .top, spacing: 12) {
                            Text("\(index + 1)")
                                .font(.subheadline.bold())
                                .foregroundStyle(.white)
                                .frame(width: 28, height: 28)
                                .background(.golfGreen, in: Circle())

                            Text(step)
                                .font(.subheadline)
                        }
                    }
                }
            }
            .padding(20)
        }
        .navigationTitle(drill.name)
        .navigationBarTitleDisplayMode(.large)
    }
}
