import SwiftUI

struct ConversationRow: View {
    let conversation: Conversation

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(conversation.title)
                    .font(.subheadline.weight(.medium))
                    .lineLimit(1)

                Spacer()

                Text(conversation.updatedAt.relativeFormatted)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            if let summary = conversation.summary {
                Text(summary)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            } else if let lastMessage = conversation.messages.last {
                Text(lastMessage.content)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }

            Text("\(conversation.messages.count) messages")
                .font(.caption2)
                .foregroundStyle(.tertiary)
        }
        .padding(.vertical, 2)
    }
}
