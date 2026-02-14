import SwiftUI

struct ChatBubbleView: View {
    let message: ChatMessage
    var isLastInGroup: Bool = true
    var isActivelyStreaming: Bool = false

    private var isUser: Bool { message.role == .user }

    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            if isUser { Spacer(minLength: 60) }

            VStack(alignment: isUser ? .trailing : .leading, spacing: 4) {
                if !message.imageReferences.isEmpty {
                    ForEach(message.imageReferences, id: \.self) { path in
                        if let uiImage = UIImage(contentsOfFile: path) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: 220, maxHeight: 280)
                                .clipShape(RoundedRectangle(cornerRadius: 18))
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
                    formattedText(message.content)
                        .textSelection(.enabled)
                        .font(.body)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .foregroundStyle(isUser ? .white : .primary)
                        .background(bubbleBackground, in: MessageBubbleShape(isUser: isUser, hasTail: isLastInGroup))
                } else if isActivelyStreaming && !isUser {
                    TypingIndicator()
                        .padding(.horizontal, 12)
                        .padding(.vertical, 10)
                        .background(bubbleBackground, in: MessageBubbleShape(isUser: false, hasTail: isLastInGroup))
                }
            }

            if !isUser { Spacer(minLength: 60) }
        }
        .padding(.horizontal, 12)
        .padding(isUser ? .trailing : .leading, isLastInGroup ? 0 : 10)
    }

    /// Renders markdown for assistant messages, plain text for user messages.
    /// During active streaming, renders plain text to avoid flickering from incomplete markdown.
    private func formattedText(_ content: String) -> Text {
        guard !isUser, !isActivelyStreaming else {
            return Text(content)
        }
        if let attributed = try? AttributedString(
            markdown: content,
            options: .init(interpretedSyntax: .inlineOnlyPreservingWhitespace)
        ) {
            return Text(attributed)
        }
        return Text(content)
    }

    private var bubbleBackground: Color {
        isUser ? Color(red: 0, green: 0.478, blue: 1.0) : Color(.systemGray5)
    }
}

// MARK: - iMessage-style bubble shape with tail

struct MessageBubbleShape: Shape {
    let isUser: Bool
    let hasTail: Bool

    func path(in rect: CGRect) -> Path {
        let radius: CGFloat = 18
        let tailSize: CGFloat = 6

        if !hasTail {
            return Path(roundedRect: rect, cornerRadius: radius)
        }

        var path = Path()

        if isUser {
            // User bubble: tail on bottom-right
            let tailX = rect.maxX
            let tailY = rect.maxY

            path.move(to: CGPoint(x: rect.minX + radius, y: rect.minY))
            // Top edge
            path.addLine(to: CGPoint(x: rect.maxX - radius, y: rect.minY))
            // Top-right corner
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX, y: rect.minY + radius),
                control: CGPoint(x: rect.maxX, y: rect.minY)
            )
            // Right edge
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - radius))
            // Bottom-right: tail
            path.addQuadCurve(
                to: CGPoint(x: tailX + tailSize, y: tailY),
                control: CGPoint(x: rect.maxX, y: rect.maxY)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX - radius, y: rect.maxY),
                control: CGPoint(x: rect.maxX - 2, y: rect.maxY)
            )
            // Bottom edge
            path.addLine(to: CGPoint(x: rect.minX + radius, y: rect.maxY))
            // Bottom-left corner
            path.addQuadCurve(
                to: CGPoint(x: rect.minX, y: rect.maxY - radius),
                control: CGPoint(x: rect.minX, y: rect.maxY)
            )
            // Left edge
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + radius))
            // Top-left corner
            path.addQuadCurve(
                to: CGPoint(x: rect.minX + radius, y: rect.minY),
                control: CGPoint(x: rect.minX, y: rect.minY)
            )
        } else {
            // Assistant bubble: tail on bottom-left
            let tailX = rect.minX
            let tailY = rect.maxY

            path.move(to: CGPoint(x: rect.minX + radius, y: rect.minY))
            // Top edge
            path.addLine(to: CGPoint(x: rect.maxX - radius, y: rect.minY))
            // Top-right corner
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX, y: rect.minY + radius),
                control: CGPoint(x: rect.maxX, y: rect.minY)
            )
            // Right edge
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - radius))
            // Bottom-right corner
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX - radius, y: rect.maxY),
                control: CGPoint(x: rect.maxX, y: rect.maxY)
            )
            // Bottom edge
            path.addLine(to: CGPoint(x: rect.minX + radius, y: rect.maxY))
            // Bottom-left: tail
            path.addQuadCurve(
                to: CGPoint(x: tailX - tailSize, y: tailY),
                control: CGPoint(x: rect.minX + 2, y: rect.maxY)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.minX, y: rect.maxY - radius),
                control: CGPoint(x: rect.minX, y: rect.maxY)
            )
            // Left edge
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + radius))
            // Top-left corner
            path.addQuadCurve(
                to: CGPoint(x: rect.minX + radius, y: rect.minY),
                control: CGPoint(x: rect.minX, y: rect.minY)
            )
        }

        path.closeSubpath()
        return path
    }
}

// MARK: - Typing Indicator

struct TypingIndicator: View {
    @State private var activeDot = 0

    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<3, id: \.self) { index in
                Circle()
                    .fill(Color(.systemGray3))
                    .frame(width: 7, height: 7)
                    .scaleEffect(activeDot == index ? 1.0 : 0.6)
                    .opacity(activeDot == index ? 1.0 : 0.4)
                    .animation(.easeInOut(duration: 0.3), value: activeDot)
            }
        }
        .task {
            while !Task.isCancelled {
                try? await Task.sleep(for: .milliseconds(400))
                activeDot = (activeDot + 1) % 3
            }
        }
    }
}
