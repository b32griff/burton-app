import SwiftUI

enum ChatSheet: Identifiable {
    case videoPicker, videoRecorder
    var id: Self { self }
}

extension Notification.Name {
    static let startNewConversation = Notification.Name("startNewConversation")
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
                HStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundStyle(.orange)
                    Text(error)
                        .font(.caption)
                        .foregroundStyle(.red)
                    Spacer()
                    Button {
                        viewModel.errorMessage = nil
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 6)
                .background(Color(.systemGray6))
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
        .onReceive(NotificationCenter.default.publisher(for: .startNewConversation)) { _ in
            viewModel.startNewConversation()
        }
    }

    private var emptyState: some View {
        GeometryReader { geo in
            ScrollView {
                VStack(spacing: 0) {
                    Spacer(minLength: 0)

                    CaddieLogoView(size: 96, style: .badge)

                    Text("Caddie AI")
                        .font(.title.bold())
                        .padding(.top, 20)

                    Text(greeting)
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .padding(.top, 4)

                    VStack(spacing: 12) {
                        ForEach(personalizedSuggestions, id: \.text) { suggestion in
                            suggestionButton(suggestion.text)
                        }
                    }
                    .padding(.top, 40)

                    Spacer(minLength: 20)
                }
                .frame(minHeight: geo.size.height)
            }
            .scrollBounceBehavior(.basedOnSize)
        }
    }

    private var greeting: String {
        let hour = Calendar.current.component(.hour, from: Date())
        let name = appState.userProfile.name
        if name.isEmpty {
            switch hour {
            case 5..<12: return "Good morning — what are we working on?"
            case 12..<17: return "Good afternoon — what are we working on?"
            default: return "Good evening — what are we working on?"
            }
        } else {
            switch hour {
            case 5..<12: return "Good morning, \(name)"
            case 12..<17: return "Good afternoon, \(name)"
            default: return "Good evening, \(name)"
            }
        }
    }

    private func suggestionButton(_ text: String) -> some View {
        Button {
            viewModel.inputText = text
            viewModel.sendMessage()
        } label: {
            Text(text)
                .font(.body)
                .foregroundStyle(.primary)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 18)
                .padding(.vertical, 14)
                .background(Color(.systemGray6), in: RoundedRectangle(cornerRadius: 12))
        }
        .padding(.horizontal, 24)
    }

    private var messageList: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack(spacing: 2) {
                    let messages = viewModel.currentConversation.messages
                    ForEach(Array(messages.enumerated()), id: \.element.id) { index, message in
                        let isLastInGroup = isLastMessageInGroup(at: index, in: messages)
                        let showTimestamp = shouldShowTimestamp(at: index, in: messages)

                        VStack(spacing: 0) {
                            if showTimestamp {
                                Text(message.timestamp, style: .time)
                                    .font(.caption2)
                                    .foregroundStyle(.secondary)
                                    .padding(.vertical, 8)
                            }

                            ChatBubbleView(
                                message: message,
                                isLastInGroup: isLastInGroup,
                                isActivelyStreaming: viewModel.isStreaming && index == messages.count - 1
                            )
                                .padding(.bottom, isLastInGroup ? 8 : 0)
                        }
                        .id(message.id)
                    }

                    // Video analyzing indicator
                    if viewModel.isAnalyzingVideo {
                        HStack(spacing: 8) {
                            ProgressView()
                                .controlSize(.small)
                            Text("Analyzing your swing...")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 8)
                    }

                    Color.clear
                        .frame(height: 1)
                        .id("bottom")
                }
                .padding(.vertical, 12)
            }
            .scrollDismissesKeyboard(.interactively)
            .onChange(of: viewModel.currentConversation.messages.count) {
                withAnimation(.easeOut(duration: 0.2)) {
                    proxy.scrollTo("bottom", anchor: .bottom)
                }
            }
            .onChange(of: viewModel.currentConversation.messages.last?.content) {
                proxy.scrollTo("bottom", anchor: .bottom)
            }
            .onChange(of: viewModel.isAnalyzingVideo) {
                if viewModel.isAnalyzingVideo {
                    withAnimation(.easeOut(duration: 0.2)) {
                        proxy.scrollTo("bottom", anchor: .bottom)
                    }
                }
            }
        }
    }

    private var personalizedSuggestions: [(text: String, icon: String)] {
        let goals = appState.userProfile.goals
        var suggestions: [(text: String, icon: String)] = []

        // Map user goals to relevant prompts
        let goalPrompts: [ImprovementGoal: (text: String, icon: String)] = [
            .distance: ("How do I add distance off the tee?", "arrow.up.right"),
            .accuracy: ("I keep missing fairways right", "arrow.turn.up.right"),
            .shortGame: ("Help with my chipping", "flag"),
            .putting: ("I keep three-putting", "circle.dotted"),
            .consistency: ("My ball striking is inconsistent", "arrow.triangle.2.circlepath"),
            .mentalGame: ("I get nervous on the first tee", "brain.head.profile"),
            .courseManagement: ("How to play a tight par 4?", "map"),
            .lowerScores: ("Fastest way to drop 5 strokes?", "chart.line.downtrend.xyaxis"),
        ]

        for goal in goals {
            if let prompt = goalPrompts[goal], suggestions.count < 3 {
                suggestions.append(prompt)
            }
        }

        // Fill remaining slots with defaults
        let defaults: [(text: String, icon: String)] = [
            ("I keep slicing my driver", "arrow.turn.up.right"),
            ("30-minute practice plan", "clock"),
            ("I'm hitting fat shots", "arrow.down.to.line"),
            ("Help with my short game", "flag"),
        ]
        for d in defaults where suggestions.count < 4 {
            if !suggestions.contains(where: { $0.text == d.text }) {
                suggestions.append(d)
            }
        }

        return Array(suggestions.prefix(4))
    }

    private func isLastMessageInGroup(at index: Int, in messages: [ChatMessage]) -> Bool {
        guard index < messages.count - 1 else { return true }
        return messages[index].role != messages[index + 1].role
    }

    private func shouldShowTimestamp(at index: Int, in messages: [ChatMessage]) -> Bool {
        guard index > 0 else { return true }
        let gap = messages[index].timestamp.timeIntervalSince(messages[index - 1].timestamp)
        return gap > 300 // Show timestamp if 5+ minutes between messages
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
                        Text("Chat with Caddie to build your swing profile.")
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
