import SwiftUI

struct SectionHeader: View {
    let title: String
    var action: (() -> Void)?
    var actionLabel: String = "See All"

    var body: some View {
        HStack {
            Text(title)
                .font(.title3.bold())

            Spacer()

            if let action {
                Button(actionLabel, action: action)
                    .font(.subheadline)
                    .foregroundStyle(.golfGreen)
            }
        }
    }
}
