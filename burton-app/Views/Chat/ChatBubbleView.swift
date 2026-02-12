import SwiftUI

struct ChatBubbleView: View {
    let message: ChatMessage

    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            if message.role == .user { Spacer(minLength: 48) }

            VStack(alignment: message.role == .user ? .trailing : .leading, spacing: 4) {
                if !message.imageReferences.isEmpty {
                    ForEach(message.imageReferences, id: \.self) { path in
                        if let uiImage = UIImage(contentsOfFile: path) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: 220, maxHeight: 280)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                                .overlay(
                                    Image(systemName: "play.circle.fill")
                                        .font(.system(size: 36))
                                        .foregroundStyle(.white.opacity(0.9))
                                        .shadow(radius: 4)
                                )
                        }
                    }
                }

                if !message.content.isEmpty {
                    Text(message.content)
                        .textSelection(.enabled)
                        .padding(.horizontal, 14)
                        .padding(.vertical, 10)
                        .background(bubbleBackground, in: bubbleShape)
                        .foregroundStyle(message.role == .user ? .white : .primary)
                }

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
