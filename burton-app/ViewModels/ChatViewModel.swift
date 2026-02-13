import SwiftUI
import AVFoundation

@Observable
class ChatViewModel {
    var currentConversation: Conversation
    var inputText = ""
    var isStreaming = false
    var showVideoPicker = false
    var errorMessage: String?

    // Staged video attachment (shown in input bar before sending)
    var stagedVideoURL: URL?
    var stagedThumbnailPath: String?

    private var streamTask: Task<Void, Never>?
    private var appState: AppState?
    private var memoryManager: SwingMemoryManager?

    init(conversation: Conversation? = nil) {
        self.currentConversation = conversation ?? Conversation()
    }

    func configure(appState: AppState, memoryManager: SwingMemoryManager) {
        self.appState = appState
        self.memoryManager = memoryManager
        cleanupEmptyMessages()
    }

    // MARK: - Send Message

    func sendMessage() {
        let text = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
        let hasVideo = stagedVideoURL != nil
        guard !text.isEmpty || hasVideo else { return }

        // Safety: if streaming got stuck, force-reset it
        if isStreaming {
            streamTask?.cancel()
            streamTask = nil
            isStreaming = false
        }

        let messageText = text.isEmpty ? "Analyze my golf swing from this video." : text
        inputText = ""
        errorMessage = nil

        // If there's a staged video, send as video analysis
        if let videoURL = stagedVideoURL {
            let thumbnailPath = stagedThumbnailPath
            stagedVideoURL = nil
            stagedThumbnailPath = nil
            sendVideoWithMessage(url: videoURL, text: messageText, thumbnailPath: thumbnailPath)
            return
        }

        let userMessage = ChatMessage(role: .user, content: messageText)
        currentConversation.messages.append(userMessage)
        currentConversation.updatedAt = Date()

        let assistantMessage = ChatMessage(role: .assistant, content: "")
        currentConversation.messages.append(assistantMessage)

        isStreaming = true

        streamTask = Task { [weak self] in
            guard let self else { return }

            var failed = false

            do {
                let systemPrompt = self.buildSystemPrompt()
                let apiMessages = self.buildAPIMessages()

                let stream = ClaudeAPIService.streamMessage(
                    systemPrompt: systemPrompt,
                    messages: apiMessages
                )

                for try await chunk in stream {
                    if Task.isCancelled { break }
                    await MainActor.run {
                        let lastIndex = self.currentConversation.messages.count - 1
                        self.currentConversation.messages[lastIndex].content += chunk
                    }
                }
            } catch {
                failed = true
                await MainActor.run {
                    if let last = self.currentConversation.messages.last, last.content.isEmpty {
                        self.currentConversation.messages.removeLast()
                    }
                    self.errorMessage = error.localizedDescription
                }
            }

            // Always runs — guaranteed to reset isStreaming
            await MainActor.run {
                self.isStreaming = false
                self.persistConversation()
                if !failed {
                    self.autoTitleIfNeeded()
                    self.triggerProfileUpdateIfNeeded()
                }
            }
        }
    }

    // MARK: - Video Staging

    func stageVideo(url: URL) {
        stagedVideoURL = url
        stagedThumbnailPath = saveThumbnail(from: url)
    }

    func clearStagedVideo() {
        if let url = stagedVideoURL {
            try? FileManager.default.removeItem(at: url)
        }
        stagedVideoURL = nil
        stagedThumbnailPath = nil
    }

    // MARK: - Video Analysis (internal)

    private func sendVideoWithMessage(url: URL, text: String, thumbnailPath: String?) {
        errorMessage = nil
        isStreaming = true

        let userMessage = ChatMessage(
            role: .user,
            content: text,
            imageReferences: thumbnailPath.map { [$0] } ?? []
        )
        currentConversation.messages.append(userMessage)
        currentConversation.updatedAt = Date()

        let assistantMessage = ChatMessage(role: .assistant, content: "")
        currentConversation.messages.append(assistantMessage)

        streamTask = Task { [weak self] in
            guard let self else { return }

            var failed = false

            do {
                let frames = try await VideoFrameExtractor.extractKeyFrames(from: url)

                guard !frames.isEmpty else {
                    await MainActor.run {
                        self.currentConversation.messages.removeLast()
                        self.errorMessage = "Could not extract frames from video."
                    }
                    failed = true
                    // Fall through to cleanup below
                    throw ClaudeAPIService.APIError.parseError
                }

                // Build image content blocks for the API message
                var contentBlocks: [[String: Any]] = []
                for frameData in frames {
                    let base64 = frameData.base64EncodedString()
                    contentBlocks.append([
                        "type": "image",
                        "source": [
                            "type": "base64",
                            "media_type": "image/jpeg",
                            "data": base64
                        ]
                    ])
                }
                contentBlocks.append([
                    "type": "text",
                    "text": "\(text)\n\nThese images are sequential frames from one continuous golf swing video, from setup through finish. Analyze this swing fresh — describe what you actually see in each phase before diagnosing. Follow your full analysis protocol."
                ])

                let systemPrompt = self.buildSystemPrompt(videoMode: true)
                let messages: [[String: Any]] = [
                    ["role": "user", "content": contentBlocks]
                ]

                let stream = ClaudeAPIService.streamMessage(
                    systemPrompt: systemPrompt,
                    messages: messages,
                    maxTokens: 4096
                )

                for try await chunk in stream {
                    if Task.isCancelled { break }
                    await MainActor.run {
                        let lastIndex = self.currentConversation.messages.count - 1
                        self.currentConversation.messages[lastIndex].content += chunk
                    }
                }
            } catch {
                if !failed {
                    failed = true
                    await MainActor.run {
                        if let last = self.currentConversation.messages.last, last.content.isEmpty {
                            self.currentConversation.messages.removeLast()
                        }
                        self.errorMessage = error.localizedDescription
                    }
                }
            }

            // Always runs — guaranteed to reset isStreaming and clean up
            await MainActor.run {
                self.isStreaming = false
                self.persistConversation()
                if !failed {
                    self.triggerProfileUpdateIfNeeded(hasVideo: true)
                }
            }
            try? FileManager.default.removeItem(at: url)
        }
    }

    // MARK: - Stop Streaming

    func stopStreaming() {
        streamTask?.cancel()
        streamTask = nil
        isStreaming = false
        persistConversation()
    }

    // MARK: - New Conversation

    func startNewConversation() {
        persistConversation()
        clearStagedVideo()
        currentConversation = Conversation()
        inputText = ""
        errorMessage = nil
    }

    func loadConversation(_ conversation: Conversation) {
        persistConversation()
        currentConversation = conversation
        cleanupEmptyMessages()
        inputText = ""
        errorMessage = nil
    }

    // MARK: - Private

    /// Remove any trailing empty assistant messages left from a stuck stream
    private func cleanupEmptyMessages() {
        while let last = currentConversation.messages.last,
              last.role == .assistant, last.content.isEmpty {
            currentConversation.messages.removeLast()
        }
    }

    private func buildSystemPrompt(videoMode: Bool = false) -> String {
        guard let appState else { return "" }

        let recentSummaries = appState.conversations
            .prefix(3)
            .compactMap(\.summary)

        return SystemPromptBuilder.build(
            userProfile: appState.userProfile,
            swingProfile: memoryManager?.swingProfile ?? .empty,
            recentConversationSummaries: recentSummaries,
            videoAnalysisMode: videoMode
        )
    }

    private func buildAPIMessages() -> [[String: Any]] {
        currentConversation.messages.dropLast().compactMap { msg -> [String: Any]? in
            guard !msg.content.isEmpty else { return nil }
            return [
                "role": msg.role.rawValue,
                "content": msg.content
            ]
        }
    }

    private func persistConversation() {
        guard let appState, !currentConversation.messages.isEmpty else { return }

        if appState.conversations.contains(where: { $0.id == currentConversation.id }) {
            appState.updateConversation(currentConversation)
        } else {
            appState.addConversation(currentConversation)
        }
    }

    private func autoTitleIfNeeded() {
        guard currentConversation.messages.count == 2,
              currentConversation.title == "New Conversation"
        else { return }

        let firstUserMessage = currentConversation.messages.first?.content ?? ""

        Task {
            do {
                let title = try await ClaudeAPIService.sendSimpleMessage(
                    systemPrompt: "Generate a short title (3-6 words) for this golf coaching conversation. Respond with ONLY the title, no quotes or punctuation.",
                    userMessage: firstUserMessage
                )

                await MainActor.run {
                    self.currentConversation.title = String(title.prefix(50)).trimmingCharacters(in: .whitespacesAndNewlines)
                    self.persistConversation()
                }
            } catch {
                // Title generation is best-effort
            }
        }
    }

    private func saveThumbnail(from videoURL: URL) -> String? {
        let asset = AVURLAsset(url: videoURL)
        let generator = AVAssetImageGenerator(asset: asset)
        generator.appliesPreferredTrackTransform = true
        generator.maximumSize = CGSize(width: 600, height: 600)

        guard let cgImage = try? generator.copyCGImage(at: .zero, actualTime: nil) else { return nil }

        let uiImage = UIImage(cgImage: cgImage)
        guard let jpegData = uiImage.jpegData(compressionQuality: 0.8) else { return nil }

        let thumbnailDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("thumbnails", isDirectory: true)
        try? FileManager.default.createDirectory(at: thumbnailDir, withIntermediateDirectories: true)

        let fileName = "\(UUID().uuidString).jpg"
        let fileURL = thumbnailDir.appendingPathComponent(fileName)

        do {
            try jpegData.write(to: fileURL)
            return fileURL.path
        } catch {
            return nil
        }
    }

    private func triggerProfileUpdateIfNeeded(hasVideo: Bool = false) {
        guard currentConversation.messages.count >= 2,
              let memoryManager
        else { return }

        Task {
            await memoryManager.updateProfile(from: currentConversation, hasVideo: hasVideo)

            await MainActor.run {
                self.appState?.updateSwingProfile(memoryManager.swingProfile)
            }

            do {
                let messagesText = currentConversation.messages.map { "\($0.role.rawValue): \($0.content.prefix(200))" }.joined(separator: "\n")
                let summary = try await ClaudeAPIService.sendSimpleMessage(
                    systemPrompt: "Summarize this golf coaching conversation in 1-2 sentences. Respond with ONLY the summary.",
                    userMessage: messagesText
                )

                await MainActor.run {
                    self.currentConversation.summary = summary.trimmingCharacters(in: .whitespacesAndNewlines)
                    self.persistConversation()
                }
            } catch {
                // Summary generation is best-effort
            }
        }
    }
}
