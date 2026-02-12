import SwiftUI

struct SwingAnalysisView: View {
    @State private var viewModel = SwingAnalysisViewModel()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("What's happening with your swing?")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .padding(.horizontal)

                // Category filters
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(SwingCategory.allCases) { category in
                            categoryChip(category)
                        }
                    }
                    .padding(.horizontal)
                }

                // Issues grid
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.filteredIssues) { issue in
                        NavigationLink(value: issue.id) {
                            issueRow(issue)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Swing Tips")
        .navigationDestination(for: String.self) { issueID in
            if let issue = viewModel.allIssues.first(where: { $0.id == issueID }) {
                SwingIssueDetailView(issue: issue, viewModel: viewModel)
            }
        }
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

    private func issueRow(_ issue: SwingIssue) -> some View {
        HStack(spacing: 14) {
            Image(systemName: issue.icon)
                .font(.title2)
                .foregroundStyle(.golfGreen)
                .frame(width: 44, height: 44)
                .background(.golfGreen.opacity(0.12), in: RoundedRectangle(cornerRadius: 10))

            VStack(alignment: .leading, spacing: 4) {
                Text(issue.name)
                    .font(.headline)
                    .foregroundStyle(.primary)
                Text(issue.description)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
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
