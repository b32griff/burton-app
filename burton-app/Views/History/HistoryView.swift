import SwiftUI

struct HistoryView: View {
    @Environment(AppState.self) private var appState
    @Environment(SwingMemoryManager.self) private var memoryManager
    @State private var viewModel = HistoryViewModel()
    @State private var selectedConversation: Conversation?

    var body: some View {
        List {
            Section {
                SwingProfileCard(profile: memoryManager.swingProfile)
                    .listRowInsets(EdgeInsets())
                    .listRowBackground(Color.clear)
            }

            let filtered = viewModel.filteredConversations(from: appState.conversations)
            let grouped = viewModel.groupedByDate(filtered)

            if grouped.isEmpty && !appState.conversations.isEmpty {
                ContentUnavailableView.search(text: viewModel.searchText)
            } else if appState.conversations.isEmpty {
                Section {
                    Text("No conversations yet. Start chatting with your AI coach!")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 20)
                }
            } else {
                ForEach(grouped, id: \.0) { dateLabel, conversations in
                    Section(dateLabel) {
                        ForEach(conversations) { conversation in
                            ConversationRow(conversation: conversation)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    selectedConversation = conversation
                                }
                        }
                        .onDelete { offsets in
                            for offset in offsets {
                                appState.deleteConversation(id: conversations[offset].id)
                            }
                        }
                    }
                }
            }
        }
        .searchable(text: $viewModel.searchText, prompt: "Search conversations")
        .navigationTitle("History")
        .navigationDestination(item: $selectedConversation) { conversation in
            ChatView(initialConversation: conversation)
        }
    }
}
