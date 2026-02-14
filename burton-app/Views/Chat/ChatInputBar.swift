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

            HStack(alignment: .bottom, spacing: 8) {
                Button(action: onVideoTap) {
                    Image(systemName: "video")
                        .font(.system(size: 18))
                        .foregroundStyle(.secondary)
                        .frame(width: 36, height: 36)
                        .contentShape(Rectangle())
                }
                .disabled(isStreaming)

                HStack(alignment: .bottom, spacing: 4) {
                    TextField("Ask Caddie...", text: $text, axis: .vertical)
                        .lineLimit(1...5)
                        .textFieldStyle(.plain)
                        .padding(.leading, 12)
                        .padding(.vertical, 8)

                    if isStreaming {
                        Button(action: onStop) {
                            Image(systemName: "stop.circle.fill")
                                .font(.system(size: 26))
                                .foregroundStyle(.red)
                                .frame(width: 36, height: 36)
                                .contentShape(Rectangle())
                        }
                    } else if canSend {
                        Button(action: onSend) {
                            Image(systemName: "arrow.up.circle.fill")
                                .font(.system(size: 26))
                                .foregroundStyle(.appAccent)
                                .frame(width: 36, height: 36)
                                .contentShape(Rectangle())
                        }
                    } else {
                        Image(systemName: "arrow.up.circle.fill")
                            .font(.system(size: 26))
                            .foregroundStyle(Color(.systemGray4))
                            .frame(width: 36, height: 36)
                    }
                }
                .padding(.trailing, 4)
                .background(Color(.systemGray6), in: RoundedRectangle(cornerRadius: 22))
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
        }
        .background(.bar)
    }

    private var canSend: Bool {
        !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || stagedThumbnailPath != nil
    }
}
