import SwiftUI

struct SwingIssueDetailView: View {
    let issue: SwingIssue
    let viewModel: SwingAnalysisViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header
                headerSection

                // Common Causes
                causesSection

                // Tips
                tipsSection

                // Recommended Drills
                drillsSection
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle(issue.name)
        .navigationBarTitleDisplayMode(.large)
    }

    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: issue.icon)
                    .font(.largeTitle)
                    .foregroundStyle(.golfGreen)
                Spacer()
                Text(issue.category.rawValue)
                    .font(.caption.weight(.medium))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(.golfGreen.opacity(0.12), in: Capsule())
                    .foregroundStyle(.golfGreen)
            }

            Text(issue.description)
                .font(.body)
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(.background, in: RoundedRectangle(cornerRadius: 12))
    }

    private var causesSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeader(title: "Common Causes")

            VStack(alignment: .leading, spacing: 8) {
                ForEach(issue.commonCauses, id: \.self) { cause in
                    HStack(alignment: .top, spacing: 10) {
                        Image(systemName: "exclamationmark.circle.fill")
                            .font(.subheadline)
                            .foregroundStyle(.sandTrap)
                        Text(cause)
                            .font(.subheadline)
                    }
                }
            }
            .padding()
            .background(.background, in: RoundedRectangle(cornerRadius: 12))
        }
    }

    private var tipsSection: some View {
        let tips = viewModel.tips(for: issue)
        return Group {
            if !tips.isEmpty {
                VStack(alignment: .leading, spacing: 12) {
                    SectionHeader(title: "Expert Tips")

                    ForEach(tips) { tip in
                        TipCard(tip: tip)
                    }
                }
            }
        }
    }

    private var drillsSection: some View {
        let drills = viewModel.drills(for: issue)
        return Group {
            if !drills.isEmpty {
                VStack(alignment: .leading, spacing: 12) {
                    SectionHeader(title: "Recommended Drills")

                    ForEach(drills) { drill in
                        NavigationLink {
                            DrillDetailView(drill: drill)
                        } label: {
                            drillRow(drill)
                        }
                    }
                }
            }
        }
    }

    private func drillRow(_ drill: Drill) -> some View {
        HStack(spacing: 12) {
            Image(systemName: "figure.strengthtraining.traditional")
                .font(.title3)
                .foregroundStyle(.golfGreen)
                .frame(width: 36, height: 36)

            VStack(alignment: .leading, spacing: 2) {
                Text(drill.name)
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.primary)
                Text("\(drill.durationMinutes) min · \(drill.difficulty.rawValue)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundStyle(.tertiary)
        }
        .padding()
        .background(.background, in: RoundedRectangle(cornerRadius: 12))
    }
}
