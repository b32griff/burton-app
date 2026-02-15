import SwiftUI

struct ChatInputBar: View {
    @Binding var text: String
    @Binding var clubType: ClubType
    @Binding var cameraAngle: CameraAngle
    var isStreaming: Bool
    var stagedThumbnailPath: String?
    var onSend: () -> Void
    var onStop: () -> Void
    var onRecordVideo: () -> Void
    var onChooseFromLibrary: () -> Void
    var onClearVideo: () -> Void

    @State private var showOptions = false

    var body: some View {
        VStack(spacing: 0) {
            // Staged video thumbnail + club picker
            if let path = stagedThumbnailPath, let uiImage = UIImage(contentsOfFile: path) {
                HStack(spacing: 12) {
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

                        Button { Haptics.light(); onClearVideo() } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 20))
                                .foregroundStyle(.white, .black.opacity(0.6))
                        }
                        .buttonStyle(.plain)
                        .offset(x: 6, y: -6)
                    }

                    // Club type + camera angle pickers
                    VStack(alignment: .leading, spacing: 8) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Club")
                                .font(.caption)
                                .foregroundStyle(.secondary)

                            HStack(spacing: 6) {
                                ForEach([ClubType.driver, .iron, .wedge], id: \.self) { club in
                                    Button {
                                        Haptics.selection()
                                        clubType = club
                                    } label: {
                                        Text(club.rawValue)
                                            .font(.caption.weight(clubType == club ? .semibold : .regular))
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 6)
                                            .background(
                                                clubType == club
                                                    ? Color(red: 0, green: 0.478, blue: 1.0)
                                                    : Color(.systemGray5),
                                                in: Capsule()
                                            )
                                            .foregroundStyle(clubType == club ? .white : .primary)
                                    }
                                }
                            }
                        }

                        VStack(alignment: .leading, spacing: 4) {
                            Text("Angle")
                                .font(.caption)
                                .foregroundStyle(.secondary)

                            HStack(spacing: 6) {
                                ForEach(CameraAngle.allCases) { angle in
                                    Button {
                                        Haptics.selection()
                                        cameraAngle = angle
                                    } label: {
                                        Text(angle.shortLabel)
                                            .font(.caption.weight(cameraAngle == angle ? .semibold : .regular))
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 6)
                                            .background(
                                                cameraAngle == angle
                                                    ? Color(red: 0, green: 0.478, blue: 1.0)
                                                    : Color(.systemGray5),
                                                in: Capsule()
                                            )
                                            .foregroundStyle(cameraAngle == angle ? .white : .primary)
                                    }
                                }
                            }
                        }
                    }

                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)
                .padding(.bottom, 4)
            }

            ZStack(alignment: .bottomLeading) {
                // Options bubble
                if showOptions {
                    VStack(alignment: .leading, spacing: 2) {
                        Button {
                            Haptics.light()
                            withAnimation(.spring(duration: 0.2)) { showOptions = false }
                            onRecordVideo()
                        } label: {
                            Label("Record", systemImage: "video.fill")
                                .font(.subheadline)
                                .padding(.horizontal, 14)
                                .padding(.vertical, 10)
                        }
                        .buttonStyle(.plain)

                        Divider().padding(.leading, 14)

                        Button {
                            Haptics.light()
                            withAnimation(.spring(duration: 0.2)) { showOptions = false }
                            onChooseFromLibrary()
                        } label: {
                            Label("Library", systemImage: "photo")
                                .font(.subheadline)
                                .padding(.horizontal, 14)
                                .padding(.vertical, 10)
                        }
                        .buttonStyle(.plain)
                    }
                    .padding(4)
                    .fixedSize()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.ultraThickMaterial)
                            .shadow(color: .black.opacity(0.15), radius: 16, y: 6)
                            .shadow(color: .black.opacity(0.05), radius: 2, y: 1)
                    )
                    .padding(.leading, 10)
                    .padding(.bottom, 54)
                    .transition(.scale(scale: 0.5, anchor: .bottomLeading).combined(with: .opacity))
                }

                // Input bar
                HStack(alignment: .bottom, spacing: 8) {
                    // + button (iMessage style)
                    Button {
                        Haptics.soft()
                        withAnimation(.spring(duration: 0.25)) {
                            showOptions.toggle()
                        }
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 30))
                            .symbolRenderingMode(.hierarchical)
                            .foregroundStyle(showOptions ? .appAccent : .secondary)
                            .frame(width: 36, height: 36)
                            .contentShape(Rectangle())
                    }
                    .buttonStyle(.plain)

                    // Text field capsule with inline send button
                    HStack(alignment: .bottom, spacing: 4) {
                        TextField("Message", text: $text, axis: .vertical)
                            .lineLimit(1...5)
                            .textFieldStyle(.plain)
                            .padding(.leading, 12)
                            .padding(.vertical, 8)
                            .onTapGesture {
                                if showOptions {
                                    withAnimation(.spring(duration: 0.2)) {
                                        showOptions = false
                                    }
                                }
                            }

                        if isStreaming && stagedThumbnailPath == nil {
                            Button { Haptics.medium(); onStop() } label: {
                                Image(systemName: "stop.circle.fill")
                                    .font(.system(size: 26))
                                    .foregroundStyle(.red)
                                    .frame(width: 36, height: 36)
                                    .contentShape(Rectangle())
                            }
                            .buttonStyle(.plain)
                        } else if canSend {
                            Button { Haptics.light(); onSend() } label: {
                                Image(systemName: "arrow.up.circle.fill")
                                    .font(.system(size: 26))
                                    .foregroundStyle(Color(red: 0, green: 0.478, blue: 1.0))
                                    .frame(width: 36, height: 36)
                                    .contentShape(Rectangle())
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.trailing, 4)
                    .background(Color(.systemGray6), in: RoundedRectangle(cornerRadius: 22))
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
            }
        }
        .background(.bar)
    }

    private var canSend: Bool {
        !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || stagedThumbnailPath != nil
    }
}
