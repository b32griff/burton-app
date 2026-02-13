import SwiftUI

enum ChatSheet: Identifiable {
    case videoPicker, videoRecorder, settings
    var id: Self { self }
}

struct ChatView: View {
    @Environment(AppState.self) private var appState
    @Environment(SwingMemoryManager.self) private var memoryManager
    @State private var viewModel = ChatViewModel()
    @State private var activeSheet: ChatSheet?
    @State private var showVideoOptions = false

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
                stagedThumbnailPath: viewModel.stagedThumbnailPath,
                onSend: { viewModel.sendMessage() },
                onStop: { viewModel.stopStreaming() },
                onVideoTap: { showVideoOptions = true },
                onClearVideo: { viewModel.clearStagedVideo() }
            )
        }
        .navigationTitle(viewModel.currentConversation.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    activeSheet = .settings
                } label: {
                    Image(systemName: "gearshape")
                }
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    viewModel.startNewConversation()
                } label: {
                    Image(systemName: "plus.message")
                }
            }
        }
        .sheet(item: $activeSheet) { sheet in
            switch sheet {
            case .videoPicker:
                VideoPicker { url in
                    viewModel.stageVideo(url: url)
                }
            case .videoRecorder:
                VideoRecorder { url in
                    viewModel.stageVideo(url: url)
                }
            case .settings:
                SettingsSheet()
            }
        }
        .confirmationDialog("Add Video", isPresented: $showVideoOptions) {
            Button("Record Video") {
                activeSheet = .videoRecorder
            }
            Button("Choose from Library") {
                activeSheet = .videoPicker
            }
            Button("Cancel", role: .cancel) {}
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

                Text("Describe your swing issues or upload a video and I'll help you fix them.")
                    .font(.body)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)

                VStack(alignment: .leading, spacing: 12) {
                    suggestionButton("I keep slicing my driver")
                    suggestionButton("What drills can help my short game?")
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
            .onChange(of: viewModel.currentConversation.messages.count) {
                // Only scroll when a new message is added (user sends), not during streaming
                if let lastMessage = viewModel.currentConversation.messages.last {
                    withAnimation(.easeOut(duration: 0.2)) {
                        proxy.scrollTo(lastMessage.id, anchor: .bottom)
                    }
                }
            }
        }
    }
}

// MARK: - Settings Sheet

struct SettingsSheet: View {
    @Environment(AppState.self) private var appState
    @Environment(SwingMemoryManager.self) private var memoryManager
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var handicapText = ""
    @State private var skillLevel: SkillLevel = .beginner
    @State private var showResetConfirmation = false

    var body: some View {
        NavigationStack {
            Form {
                Section("Profile") {
                    TextField("Name", text: $name)

                    HStack {
                        Text("Handicap")
                        Spacer()
                        TextField("Optional", text: $handicapText)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 80)
                    }

                    Picker("Skill Level", selection: $skillLevel) {
                        ForEach(SkillLevel.allCases) { level in
                            Text(level.rawValue).tag(level)
                        }
                    }
                }

                Section("Swing Memory") {
                    if memoryManager.swingProfile.isEmpty {
                        Text("Chat with your coach to build your swing profile.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    } else {
                        if !memoryManager.swingProfile.summary.isEmpty {
                            Text(memoryManager.swingProfile.summary)
                                .font(.subheadline)
                        }

                        Text("\(memoryManager.swingProfile.identifiedIssues.count) issues, \(memoryManager.swingProfile.strengths.count) strengths tracked")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }

                Section {
                    Button("Reset Everything", role: .destructive) {
                        showResetConfirmation = true
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        let handicap = Double(handicapText)
                        appState.updateProfile(
                            name: name,
                            handicap: handicap,
                            skillLevel: skillLevel,
                            goals: appState.userProfile.goals
                        )
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .alert("Reset Everything?", isPresented: $showResetConfirmation) {
                Button("Reset", role: .destructive) {
                    memoryManager.clearProfile()
                    appState.resetOnboarding()
                    dismiss()
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("This will delete all data including conversations and swing profile.")
            }
            .onAppear {
                name = appState.userProfile.name
                handicapText = appState.userProfile.handicap.map { String($0) } ?? ""
                skillLevel = appState.userProfile.skillLevel
            }
        }
    }
}
