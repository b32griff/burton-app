import SwiftUI

struct ConversationSidebar: View {
    @Environment(AppState.self) private var appState
    @Binding var isOpen: Bool

    var onSelect: (Conversation) -> Void
    var onNewConversation: () -> Void

    @State private var searchText = ""

    private let sidebarWidth: CGFloat = 320

    /// Only show conversations that have at least one message
    private var visibleConversations: [Conversation] {
        appState.conversations.filter { !$0.messages.isEmpty }
    }

    private var filteredConversations: [Conversation] {
        if searchText.isEmpty {
            return visibleConversations
        }
        return visibleConversations.filter {
            $0.title.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        ZStack(alignment: .leading) {
            // Dimmed background — only visible when open
            Color.black.opacity(isOpen ? 0.3 : 0)
                .ignoresSafeArea()
                .onTapGesture {
                    isOpen = false
                }
                .allowsHitTesting(isOpen)

            // Sidebar panel
            HStack(spacing: 0) {
                VStack(spacing: 0) {
                    // Search bar + new chat button
                    HStack(spacing: 12) {
                        HStack(spacing: 8) {
                            Image(systemName: "magnifyingglass")
                                .foregroundStyle(.secondary)
                                .font(.system(size: 15))
                            TextField("Search", text: $searchText)
                                .font(.body)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 9)
                        .background(Color(.systemGray6), in: RoundedRectangle(cornerRadius: 10))

                        Button {
                            Haptics.medium()
                            isOpen = false
                            onNewConversation()
                        } label: {
                            Image(systemName: "square.and.pencil")
                                .font(.system(size: 20))
                                .foregroundStyle(.primary)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 12)
                    .padding(.bottom, 16)

                    // Conversation list
                    if visibleConversations.isEmpty {
                        VStack(spacing: 12) {
                            Image(systemName: "bubble.left.and.text.bubble.right")
                                .font(.system(size: 36))
                                .foregroundStyle(Color(.systemGray4))
                            Text("No conversations yet")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    } else {
                        ScrollView {
                            LazyVStack(alignment: .leading, spacing: 0) {
                                ForEach(filteredConversations) { conversation in
                                    Button {
                                        Haptics.light()
                                        isOpen = false
                                        onSelect(conversation)
                                    } label: {
                                        Text(conversation.title)
                                            .font(.body)
                                            .foregroundStyle(.primary)
                                            .lineLimit(1)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .padding(.horizontal, 16)
                                            .padding(.vertical, 14)
                                            .contentShape(Rectangle())
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                        }
                        .scrollDismissesKeyboard(.interactively)
                    }

                    Spacer(minLength: 0)

                    // Bottom: user profile
                    Divider()
                    HStack(spacing: 12) {
                        // Initials circle
                        Circle()
                            .fill(Color(.systemGray4))
                            .frame(width: 36, height: 36)
                            .overlay(
                                Text(initials)
                                    .font(.system(size: 13, weight: .semibold))
                                    .foregroundStyle(.white)
                            )

                        Text(displayName)
                            .font(.body.weight(.medium))
                            .foregroundStyle(.primary)

                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 14)
                }
                .frame(width: sidebarWidth)
                .background(Color(.systemBackground))

                Spacer(minLength: 0)
            }
            .offset(x: isOpen ? 0 : -sidebarWidth)
        }
        .animation(.easeOut(duration: 0.25), value: isOpen)
        .gesture(
            DragGesture()
                .onEnded { value in
                    if value.translation.width < -80 {
                        isOpen = false
                    }
                }
        )
    }

    private var displayName: String {
        let name = appState.userProfile.name
        return name.isEmpty ? "Golfer" : name
    }

    private var initials: String {
        let name = appState.userProfile.name
        guard !name.isEmpty else { return "G" }
        let parts = name.split(separator: " ")
        if parts.count >= 2 {
            return String(parts[0].prefix(1) + parts[1].prefix(1)).uppercased()
        }
        return String(name.prefix(2)).uppercased()
    }
}
