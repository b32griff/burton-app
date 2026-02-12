import SwiftUI

struct QuickActionGrid: View {
    private let actions: [(title: String, icon: String, tab: String)] = [
        ("Diagnose Swing", "stethoscope", "swing"),
        ("Browse Drills", "list.bullet.clipboard", "drills"),
        ("Log Practice", "plus.circle", "progress"),
        ("View Progress", "chart.bar", "progress")
    ]

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeader(title: "Quick Actions")

            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(actions, id: \.title) { action in
                    quickActionCard(title: action.title, icon: action.icon)
                }
            }
        }
    }

    private func quickActionCard(title: String, icon: String) -> some View {
        VStack(spacing: 10) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(.golfGreen)
            Text(title)
                .font(.subheadline.weight(.medium))
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 12))
    }
}
