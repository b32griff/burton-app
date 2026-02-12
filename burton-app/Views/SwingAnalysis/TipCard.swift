import SwiftUI

struct TipCard: View {
    let tip: Tip
    @State private var isExpanded = false

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: "lightbulb.fill")
                    .foregroundStyle(.yellow)
                Text(tip.title)
                    .font(.subheadline.weight(.semibold))
                Spacer()
                Text(tip.difficulty.rawValue)
                    .font(.caption2.weight(.medium))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(.golfGreen.opacity(0.12), in: Capsule())
                    .foregroundStyle(.golfGreen)
            }

            Text(tip.summary)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            if isExpanded {
                Text(tip.body)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .padding(.top, 4)
            }

            Button {
                withAnimation(.easeInOut(duration: 0.25)) {
                    isExpanded.toggle()
                }
            } label: {
                HStack(spacing: 4) {
                    Text(isExpanded ? "Show Less" : "Read More")
                        .font(.caption.weight(.medium))
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .font(.caption2)
                }
                .foregroundStyle(.golfGreen)
            }
        }
        .padding()
        .background(.background, in: RoundedRectangle(cornerRadius: 12))
    }
}
