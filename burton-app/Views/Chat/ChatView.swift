import SwiftUI

struct ChatView: View {
    @Environment(AppState.self) private var appState
    @Environment(SwingMemoryManager.self) private var memoryManager
    @State private var viewModel = ChatViewModel()

    var initialConversation: Conversation?

    var body: some View {
        VStack(spacing: 0) {
            if viewModel.currentConversation.messages.isEmpty {
                emptyState
            } else {
                messageList
            }

            if let error = viewModel.errorMessage {
                Text(error)
                    .font(.caption)
                    .foregroundStyle(.red)
                    .padding(.horizontal)
                    .padding(.top, 4)
            }

            ChatInputBar(
                text: $viewModel.inputText,
                isStreaming: viewModel.isStreaming,
                onSend: { viewModel.sendMessage() },
                onStop: { viewModel.stopStreaming() },
                onVideoTap: { viewModel.showVideoPicker = true }
            )
        }
        .navigationTitle(viewModel.currentConversation.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.startNewConversation()
                } label: {
                    Image(systemName: "plus.message")
                }
            }
        }
        .sheet(isPresented: $viewModel.showVideoPicker) {
            VideoPicker { url in
                viewModel.sendVideoForAnalysis(url: url)
            }
        }
        .onAppear {
            viewModel.configure(appState: appState, memoryManager: memoryManager)
            if let initialConversation {
                viewModel.loadConversation(initialConversation)
            }
        }
    }

    private var emptyState: some View {
        ScrollView {
            VStack(spacing: 20) {
                Spacer().frame(height: 60)

                Image(systemName: "figure.golf")
                    .font(.system(size: 60))
                    .foregroundStyle(.golfGreen)

                Text("Your AI Swing Coach")
                    .font(.title2.bold())

                Text("Ask me anything about your golf game — swing mechanics, drills, course strategy, or the mental game. You can also share a video of your swing for analysis.")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)

                VStack(alignment: .leading, spacing: 12) {
                    suggestionButton("What drills can help my slice?")
                    suggestionButton("How do I improve my lag putting?")
                    suggestionButton("I keep hitting fat shots — help!")
                    suggestionButton("Create a 30-minute practice plan")
                }
                .padding(.top, 8)

                Spacer()
            }
        }
    }

    private func suggestionButton(_ text: String) -> some View {
        Button {
            viewModel.inputText = text
            viewModel.sendMessage()
        } label: {
            HStack {
                Text(text)
                    .font(.subheadline)
                    .foregroundStyle(.primary)
                Spacer()
                Image(systemName: "arrow.up.circle.fill")
                    .foregroundStyle(.golfGreen)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color(.systemGray6), in: RoundedRectangle(cornerRadius: 12))
        }
        .padding(.horizontal, 24)
    }

    private var messageList: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.currentConversation.messages) { message in
                        ChatBubbleView(message: message)
                            .id(message.id)
                    }
                }
                .padding(.vertical, 12)
            }
            .onChange(of: viewModel.currentConversation.messages.last?.content) {
                scrollToBottom(proxy: proxy)
            }
            .onChange(of: viewModel.currentConversation.messages.count) {
                scrollToBottom(proxy: proxy)
            }
        }
    }

    private func scrollToBottom(proxy: ScrollViewProxy) {
        if let lastMessage = viewModel.currentConversation.messages.last {
            withAnimation(.easeOut(duration: 0.2)) {
                proxy.scrollTo(lastMessage.id, anchor: .bottom)
            }
        }
    }
}
