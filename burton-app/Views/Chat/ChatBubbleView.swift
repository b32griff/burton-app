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
            if isUser { Spacer(minLength: 80) }

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
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }

                if !message.content.isEmpty {
                    if isUser {
                        // User: gray bubble, dark text (ChatGPT style)
                        Text(message.content)
                            .textSelection(.enabled)
                            .font(.body)
                            .foregroundStyle(.primary)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 7)
                            .background(
                                Color(.systemGray5),
                                in: RoundedRectangle(cornerRadius: 18)
                            )
                    } else if isActivelyStreaming {
                        // Assistant streaming: inline markdown with fade animation
                        inlineFormattedText(message.content)
                            .textSelection(.enabled)
                            .font(.body)
                            .foregroundStyle(.primary)
                            .textRenderer(StreamingFadeRenderer(
                                charCount: Double(message.content.count)
                            ))
                            .animation(.easeIn(duration: 0.3), value: message.content.count)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical, 4)
                    } else {
                        // Assistant final: rich block-level markdown
                        MarkdownBlockView(content: message.content)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.vertical, 4)
                    }
                } else if isActivelyStreaming && !isUser {
                    // ChatGPT-style: pulsing dot while AI is thinking
                    ThinkingIndicator()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical, 4)
                }
            }

        }
        .padding(.horizontal, 16)
        .fullScreenCover(isPresented: $showVideoPlayer) {
            if let videoPath = message.videoPath {
                VideoPlayerView(url: URL(fileURLWithPath: videoPath))
            }
        }
    }

    /// Inline markdown for streaming mode (bold/italic only, single Text view)
    private func inlineFormattedText(_ content: String) -> Text {
        // Strip ## header markers and --- horizontal rules so they don't show as raw text during streaming
        var cleaned = content.replacingOccurrences(
            of: "(?m)^#{1,4}\\s*",
            with: "",
            options: .regularExpression
        )
        cleaned = cleaned.replacingOccurrences(
            of: "(?m)^-{3,}\\s*$",
            with: "",
            options: .regularExpression
        )
        if let attributed = try? AttributedString(
            markdown: cleaned,
            options: .init(interpretedSyntax: .inlineOnlyPreservingWhitespace)
        ) {
            return Text(attributed)
        }
        return Text(cleaned)
    }
}

// MARK: - Block-Level Markdown Renderer

struct MarkdownBlockView: View {
    let content: String

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            let blocks = Self.parseBlocks(content)
            ForEach(Array(blocks.enumerated()), id: \.offset) { _, block in
                renderBlock(block)
            }
        }
    }

    @ViewBuilder
    private func renderBlock(_ block: MarkdownBlock) -> some View {
        switch block {
        case .header(_, let text):
            inlineText(text)
                .font(.title3.bold())
        case .bulletList(let items):
            VStack(alignment: .leading, spacing: 12) {
                ForEach(Array(items.enumerated()), id: \.offset) { _, item in
                    HStack(alignment: .firstTextBaseline, spacing: 8) {
                        Text("\u{2022}")
                            .foregroundStyle(.primary)
                        inlineText(item)
                            .font(.body)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
        case .numberedList(let items):
            VStack(alignment: .leading, spacing: 14) {
                ForEach(Array(items.enumerated()), id: \.offset) { index, item in
                    HStack(alignment: .firstTextBaseline, spacing: 8) {
                        Text("\(index + 1).")
                            .foregroundStyle(.primary)
                            .monospacedDigit()
                        inlineText(item)
                            .font(.body)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
        case .horizontalRule:
            Divider()
                .padding(.vertical, 6)
        case .paragraph(let text):
            inlineText(text)
                .font(.body)
        }
    }

    private func inlineText(_ content: String) -> Text {
        if let attributed = try? AttributedString(
            markdown: content,
            options: .init(interpretedSyntax: .inlineOnlyPreservingWhitespace)
        ) {
            return Text(attributed)
        }
        return Text(content)
    }

    // MARK: - Markdown Parser

    enum MarkdownBlock {
        case paragraph(String)
        case header(level: Int, String)
        case bulletList([String])
        case numberedList([String])
        case horizontalRule
    }

    static func parseBlocks(_ content: String) -> [MarkdownBlock] {
        let lines = content.components(separatedBy: "\n")
        var blocks: [MarkdownBlock] = []
        var currentParagraphLines: [String] = []

        func flushParagraph() {
            guard !currentParagraphLines.isEmpty else { return }
            let text = currentParagraphLines.joined(separator: "\n")
            if !text.trimmingCharacters(in: .whitespaces).isEmpty {
                blocks.append(.paragraph(text))
            }
            currentParagraphLines = []
        }

        var i = 0
        while i < lines.count {
            let line = lines[i]
            let trimmed = line.trimmingCharacters(in: .whitespaces)

            // Empty line = paragraph break
            if trimmed.isEmpty {
                flushParagraph()
                i += 1
                continue
            }

            // Horizontal rule: --- or *** or ___ (3+ chars, only that char)
            if trimmed.count >= 3 {
                let chars = Set(trimmed)
                if chars.count == 1 && (chars.contains("-") || chars.contains("*") || chars.contains("_")) {
                    flushParagraph()
                    blocks.append(.horizontalRule)
                    i += 1
                    continue
                }
            }

            // Header: ## Text
            if trimmed.hasPrefix("#") {
                flushParagraph()
                var level = 0
                for ch in trimmed {
                    if ch == "#" { level += 1 } else { break }
                }
                let headerText = String(trimmed.dropFirst(level)).trimmingCharacters(in: .whitespaces)
                blocks.append(.header(level: level, headerText))
                i += 1
                continue
            }

            // Bullet list: - item or * item (but not ** which is bold, and not --- which is hr)
            if (trimmed.hasPrefix("- ") || (trimmed.hasPrefix("* ") && !trimmed.hasPrefix("**"))) {
                flushParagraph()
                var items: [String] = []
                while i < lines.count {
                    let bulletLine = lines[i].trimmingCharacters(in: .whitespaces)
                    if bulletLine.hasPrefix("- ") {
                        items.append(String(bulletLine.dropFirst(2)))
                    } else if bulletLine.hasPrefix("* ") && !bulletLine.hasPrefix("**") {
                        items.append(String(bulletLine.dropFirst(2)))
                    } else {
                        break
                    }
                    i += 1
                }
                blocks.append(.bulletList(items))
                continue
            }

            // Numbered list: 1. item, 2. item, etc.
            if trimmed.range(of: #"^\d+\.\s+"#, options: .regularExpression) != nil {
                flushParagraph()
                var items: [String] = []
                while i < lines.count {
                    let numLine = lines[i].trimmingCharacters(in: .whitespaces)
                    if let numMatch = numLine.range(of: #"^\d+\.\s+"#, options: .regularExpression) {
                        items.append(String(numLine[numMatch.upperBound...]))
                    } else {
                        break
                    }
                    i += 1
                }
                blocks.append(.numberedList(items))
                continue
            }

            // Regular text line → accumulate into paragraph
            currentParagraphLines.append(line)
            i += 1
        }

        flushParagraph()
        return blocks
    }
}

// MARK: - iMessage-style bubble shape with tail (user messages only)

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
            path.addLine(to: CGPoint(x: rect.maxX - radius, y: rect.minY))
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX, y: rect.minY + radius),
                control: CGPoint(x: rect.maxX, y: rect.minY)
            )
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - radius))
            path.addQuadCurve(
                to: CGPoint(x: tailX + tailSize, y: tailY),
                control: CGPoint(x: rect.maxX, y: rect.maxY)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX - radius, y: rect.maxY),
                control: CGPoint(x: rect.maxX - 2, y: rect.maxY)
            )
            path.addLine(to: CGPoint(x: rect.minX + radius, y: rect.maxY))
            path.addQuadCurve(
                to: CGPoint(x: rect.minX, y: rect.maxY - radius),
                control: CGPoint(x: rect.minX, y: rect.maxY)
            )
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + radius))
            path.addQuadCurve(
                to: CGPoint(x: rect.minX + radius, y: rect.minY),
                control: CGPoint(x: rect.minX, y: rect.minY)
            )
        } else {
            // Assistant bubble: tail on bottom-left (used for typing indicator)
            let tailX = rect.minX
            let tailY = rect.maxY

            path.move(to: CGPoint(x: rect.minX + radius, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX - radius, y: rect.minY))
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX, y: rect.minY + radius),
                control: CGPoint(x: rect.maxX, y: rect.minY)
            )
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - radius))
            path.addQuadCurve(
                to: CGPoint(x: rect.maxX - radius, y: rect.maxY),
                control: CGPoint(x: rect.maxX, y: rect.maxY)
            )
            path.addLine(to: CGPoint(x: rect.minX + radius, y: rect.maxY))
            path.addQuadCurve(
                to: CGPoint(x: tailX - tailSize, y: tailY),
                control: CGPoint(x: rect.minX + 2, y: rect.maxY)
            )
            path.addQuadCurve(
                to: CGPoint(x: rect.minX, y: rect.maxY - radius),
                control: CGPoint(x: rect.minX, y: rect.maxY)
            )
            path.addLine(to: CGPoint(x: rect.minX, y: rect.minY + radius))
            path.addQuadCurve(
                to: CGPoint(x: rect.minX + radius, y: rect.minY),
                control: CGPoint(x: rect.minX, y: rect.minY)
            )
        }

        path.closeSubpath()
        return path
    }
}

// MARK: - Streaming Text Fade-In (ChatGPT-style)

struct StreamingFadeRenderer: TextRenderer, Animatable {
    var charCount: Double

    var animatableData: Double {
        get { charCount }
        set { charCount = newValue }
    }

    func draw(layout: Text.Layout, in ctx: inout GraphicsContext) {
        let fadeLength = 18.0
        var index = 0
        for line in layout {
            for run in line {
                for slice in run {
                    let pos = Double(index)
                    let opacity: Double
                    if pos >= charCount {
                        opacity = 0
                    } else if pos >= charCount - fadeLength {
                        opacity = (charCount - pos) / fadeLength
                    } else {
                        opacity = 1
                    }
                    var copy = ctx
                    copy.opacity = min(1, max(0, opacity))
                    copy.draw(slice)
                    index += 1
                }
            }
        }
    }
}

// MARK: - Thinking Indicator (ChatGPT-style)

struct ThinkingIndicator: View {
    @State private var opacity: Double = 0.3

    var body: some View {
        Circle()
            .fill(Color(.systemGray3))
            .frame(width: 8, height: 8)
            .opacity(opacity)
            .onAppear {
                withAnimation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true)) {
                    opacity = 1.0
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
