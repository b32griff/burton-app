import SwiftUI

struct ChatInputBar: View {
    @Binding var text: String
    var isStreaming: Bool
    var stagedThumbnailPath: String?
    var onSend: () -> Void
    var onStop: () -> Void
    var onVideoTap: () -> Void
    var onClearVideo: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            // Staged video thumbnail preview
            if let path = stagedThumbnailPath, let uiImage = UIImage(contentsOfFile: path) {
                HStack {
                    ZStack(alignment: .topTrailing) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 80, height: 80)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay(
                                Image(systemName: "play.circle.fill")
                                    .font(.system(size: 24))
                                    .foregroundStyle(.white.opacity(0.9))
                                    .shadow(radius: 2)
                            )

                        Button(action: onClearVideo) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 20))
                                .foregroundStyle(.white, .black.opacity(0.6))
                        }
                        .offset(x: 6, y: -6)
                    }
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)
                .padding(.bottom, 4)
            }

            HStack(spacing: 12) {
                Button(action: onVideoTap) {
                    Image(systemName: "video.fill")
                        .font(.title3)
                        .foregroundStyle(.golfGreen)
                }
                .disabled(isStreaming)

                TextField("Ask your coach...", text: $text, axis: .vertical)
                    .lineLimit(1...5)
                    .textFieldStyle(.plain)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(Color(.systemGray6), in: RoundedRectangle(cornerRadius: 20))

                if isStreaming && !canSend {
                    // Only show stop button when streaming AND user hasn't typed anything
                    Button(action: onStop) {
                        Image(systemName: "stop.circle.fill")
                            .font(.title2)
                            .foregroundStyle(.red)
                    }
                } else {
                    // Show send button when user has text (even during streaming)
                    Button(action: onSend) {
                        Image(systemName: "arrow.up.circle.fill")
                            .font(.title2)
                            .foregroundStyle(canSend ? .golfGreen : .gray)
                    }
                    .disabled(!canSend)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
        }
        .background(.bar)
    }

    private var canSend: Bool {
        !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || stagedThumbnailPath != nil
    }
}
