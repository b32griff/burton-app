import SwiftUI

struct DrillLibraryView: View {
    @State private var viewModel = DrillLibraryViewModel()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Category filter chips
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(viewModel.categories) { category in
                            categoryChip(category)
                        }
                    }
                    .padding(.horizontal)
                }

                // Drill list
                if viewModel.selectedCategory == nil {
                    // Show by category
                    ForEach(viewModel.categories) { category in
                        let drills = viewModel.drills(for: category)
                        if !drills.isEmpty {
                            VStack(alignment: .leading, spacing: 12) {
                                DrillCategoryRow(category: category)
                                    .padding(.horizontal)

                                ForEach(drills) { drill in
                                    NavigationLink {
                                        DrillDetailView(drill: drill)
                                    } label: {
                                        drillRow(drill)
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                } else {
                    // Show filtered
                    ForEach(viewModel.filteredDrills) { drill in
                        NavigationLink {
                            DrillDetailView(drill: drill)
                        } label: {
                            drillRow(drill)
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.vertical)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Drills")
    }

    private func categoryChip(_ category: SwingCategory) -> some View {
        let isSelected = viewModel.selectedCategory == category
        return Button {
            withAnimation(.easeInOut(duration: 0.2)) {
                viewModel.selectCategory(category)
            }
        } label: {
            HStack(spacing: 6) {
                Image(systemName: category.icon)
                    .font(.caption)
                Text(category.rawValue)
                    .font(.subheadline.weight(.medium))
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(
                isSelected ? Color.golfGreen : Color(.systemBackground),
                in: Capsule()
            )
            .foregroundStyle(isSelected ? .white : .primary)
            .overlay(
                Capsule().strokeBorder(isSelected ? Color.clear : Color.gray.opacity(0.3))
            )
        }
    }

    private func drillRow(_ drill: Drill) -> some View {
        HStack(spacing: 14) {
            Image(systemName: "figure.strengthtraining.traditional")
                .font(.title2)
                .foregroundStyle(.golfGreen)
                .frame(width: 44, height: 44)
                .background(.golfGreen.opacity(0.12), in: RoundedRectangle(cornerRadius: 10))

            VStack(alignment: .leading, spacing: 4) {
                Text(drill.name)
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.primary)
                HStack(spacing: 8) {
                    Label("\(drill.durationMinutes) min", systemImage: "clock")
                    Text("·")
                    Text(drill.difficulty.rawValue)
                }
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
