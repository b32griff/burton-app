import SwiftUI

struct DrillCategoryRow: View {
    let category: SwingCategory

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: category.icon)
                .font(.subheadline)
                .foregroundStyle(.golfGreen)
            Text(category.rawValue)
                .font(.title3.bold())
        }
        .padding(.top, 8)
    }
}
