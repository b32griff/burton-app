import SwiftUI

struct ChatBubbleView: View {
    let message: ChatMessage

    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            if message.role == .user { Spacer(minLength: 48) }

            VStack(alignment: message.role == .user ? .trailing : .leading, spacing: 4) {
                if !message.imageReferences.isEmpty {
                    HStack(spacing: 4) {
                        ForEach(message.imageReferences, id: \.self) { _ in
                            Image(systemName: "film")
                                .font(.title3)
                                .foregroundStyle(.secondary)
                                .frame(width: 44, height: 44)
                                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8))
                        }
                    }
                }

                Text(message.content)
                    .textSelection(.enabled)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 10)
                    .background(bubbleBackground, in: bubbleShape)
                    .foregroundStyle(message.role == .user ? .white : .primary)

                Text(message.timestamp, style: .time)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }

            if message.role == .assistant { Spacer(minLength: 48) }
        }
        .padding(.horizontal, 16)
    }

    private var bubbleBackground: Color {
        message.role == .user ? .golfGreen : Color(.systemGray6)
    }

    private var bubbleShape: RoundedRectangle {
        RoundedRectangle(cornerRadius: 16)
    }
}
