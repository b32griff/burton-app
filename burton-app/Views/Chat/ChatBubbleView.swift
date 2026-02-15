import SwiftUI
import AVKit

struct ChatBubbleView: View {
    let message: ChatMessage
    var isLastInGroup: Bool = true
    var isActivelyStreaming: Bool = false

    @State private var showVideoPlayer = false

    private var isUser: Bool { message.role == .user }

    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            if isUser { Spacer(minLength: 60) }

            VStack(alignment: isUser ? .trailing : .leading, spacing: 4) {
                if !message.imageReferences.isEmpty {
                    ForEach(message.imageReferences, id: \.self) { path in
                        if let uiImage = UIImage(contentsOfFile: path) {
                            Button {
                                if message.videoPath != nil {
                                    Haptics.light()
                                    showVideoPlayer = true
                                }
                            } label: {
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
                            .buttonStyle(.plain)
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
                        .padding(.horizontal, 14)
                        .padding(.vertical, 12)
                        .background(bubbleBackground, in: MessageBubbleShape(isUser: false, hasTail: isLastInGroup))
                }
            }

            if !isUser { Spacer(minLength: 60) }
        }
        .padding(.horizontal, 12)
        .padding(isUser ? .trailing : .leading, isLastInGroup ? 0 : 10)
        .fullScreenCover(isPresented: $showVideoPlayer) {
            if let videoPath = message.videoPath {
                VideoPlayerView(url: URL(fileURLWithPath: videoPath))
            }
        }
    }

    /// Renders markdown for assistant messages, plain text for user messages.
    private func formattedText(_ content: String) -> Text {
        guard !isUser else {
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
    @State private var offsets: [CGFloat] = [0, 0, 0]

    var body: some View {
        HStack(spacing: 5) {
            ForEach(0..<3, id: \.self) { index in
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color(.systemGray2), Color(.systemGray3)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(width: 10, height: 10)
                    .shadow(color: .black.opacity(0.12), radius: 1, x: 0, y: 1)
                    .offset(y: offsets[index])
            }
        }
        .task {
            while !Task.isCancelled {
                for i in 0..<3 {
                    withAnimation(.easeInOut(duration: 0.28)) {
                        offsets[i] = -5
                    }
                    try? await Task.sleep(for: .milliseconds(140))
                    withAnimation(.easeInOut(duration: 0.28)) {
                        offsets[i] = 0
                    }
                    try? await Task.sleep(for: .milliseconds(80))
                }
                try? await Task.sleep(for: .milliseconds(400))
            }
        }
    }
}

// MARK: - Video Player

struct VideoPlayerView: View {
    let url: URL
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.black.ignoresSafeArea()

            VideoPlayer(player: AVPlayer(url: url))
                .ignoresSafeArea()

            Button {
                Haptics.light()
                dismiss()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 30))
                    .symbolRenderingMode(.hierarchical)
                    .foregroundStyle(.white)
            }
            .buttonStyle(.plain)
            .padding(.top, 12)
            .padding(.leading, 16)
        }
    }
}
