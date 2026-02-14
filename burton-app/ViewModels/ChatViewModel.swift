import SwiftUI
import AVFoundation

@Observable
class ChatViewModel {
    var currentConversation: Conversation
    var inputText = ""
    var isStreaming = false
    var isAnalyzingVideo = false
    var showVideoPicker = false
    var errorMessage: String?

    // Staged video attachment (shown in input bar before sending)
    var stagedVideoURL: URL?
    var stagedThumbnailPath: String?

    private var streamTask: Task<Void, Never>?
    private var streamGeneration = 0 // prevents old tasks from resetting isStreaming
    private var streamWatchdog: Task<Void, Never>?
    private var appState: AppState?
    private var memoryManager: SwingMemoryManager?
    private var hasConfigured = false

    init(conversation: Conversation? = nil) {
        self.currentConversation = conversation ?? Conversation()
    }

    func configure(appState: AppState, memoryManager: SwingMemoryManager) {
        self.appState = appState
        self.memoryManager = memoryManager

        guard !hasConfigured else { return }
        hasConfigured = true

        cleanupEmptyMessages()
        // Reset stuck streaming state from previous session
        if isStreaming {
            isStreaming = false
            streamTask?.cancel()
            streamTask = nil
        }
    }

    // MARK: - Send Message

    func sendMessage() {
        chatLog("sendMessage: text='\(inputText.prefix(50))' isStreaming=\(isStreaming) hasVideo=\(stagedVideoURL != nil)")
        let text = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
        let hasVideo = stagedVideoURL != nil
        guard !text.isEmpty || hasVideo else {
            chatLog("sendMessage: guard failed — empty text and no video")
            return
        }

        // Safety: if streaming got stuck, force-reset it
        if isStreaming {
            chatLog("sendMessage: force-resetting stuck stream")
            cancelWatchdog()
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

        streamGeneration += 1
        let myGeneration = streamGeneration
        isStreaming = true
        startStreamWatchdog(generation: myGeneration)

        streamTask = Task { [weak self] in
            guard let self else { return }

            var failed = false

            do {
                let systemPrompt = self.buildSystemPrompt()
                let apiMessages = self.buildAPIMessages()

                let stream = ClaudeAPIService.streamMessage(
                    systemPrompt: systemPrompt,
                    messages: apiMessages,
                    maxTokens: 4096
                )

                for try await chunk in stream {
                    if Task.isCancelled { break }
                    await MainActor.run {
                        let lastIndex = self.currentConversation.messages.count - 1
                        if lastIndex >= 0 {
                            self.currentConversation.messages[lastIndex].content += chunk
                        }
                    }
                }
            } catch {
                failed = true
                await MainActor.run {
                    // Only touch state if we're still the active stream
                    guard self.streamGeneration == myGeneration else { return }
                    if let last = self.currentConversation.messages.last, last.content.isEmpty {
                        self.currentConversation.messages.removeLast()
                    }
                    self.errorMessage = error.localizedDescription
                }
            }

            // Only reset isStreaming if we're still the active stream
            await MainActor.run {
                guard self.streamGeneration == myGeneration else { return }
                self.cancelWatchdog()
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
        if let path = stagedThumbnailPath {
            try? FileManager.default.removeItem(atPath: path)
        }
        stagedVideoURL = nil
        stagedThumbnailPath = nil
    }

    // MARK: - Video Analysis (internal)

    private func sendVideoWithMessage(url: URL, text: String, thumbnailPath: String?) {
        errorMessage = nil
        streamGeneration += 1
        let myGeneration = streamGeneration
        isStreaming = true
        startStreamWatchdog(generation: myGeneration)
        chatLog("Video send started (gen \(myGeneration))")

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
                await MainActor.run { self.isAnalyzingVideo = true }
                self.chatLog("Extracting frames...")
                let frames = try await VideoFrameExtractor.extractKeyFrames(from: url)
                self.chatLog("Got \(frames.count) frames, sizes: \(frames.map(\.count))")

                guard !frames.isEmpty else {
                    await MainActor.run {
                        guard self.streamGeneration == myGeneration else { return }
                        self.currentConversation.messages.removeLast()
                        self.errorMessage = "Could not extract frames from video."
                    }
                    failed = true
                    throw ClaudeAPIService.APIError.parseError
                }

                // Label each frame with its swing phase
                let phaseLabels: [String]
                switch frames.count {
                case 8:
                    phaseLabels = ["Setup/Address", "Early Takeaway", "Top of Backswing", "Early Downswing", "Impact Zone", "Early Follow-through", "Late Follow-through", "Finish"]
                case 6:
                    phaseLabels = ["Setup/Address", "Backswing", "Top of Backswing", "Downswing", "Impact", "Finish"]
                default:
                    phaseLabels = (0..<frames.count).map { "Frame \($0 + 1) of \(frames.count)" }
                }

                // Build content blocks with labels interleaved
                var contentBlocks: [[String: Any]] = []
                for (i, frameData) in frames.enumerated() {
                    let label = i < phaseLabels.count ? phaseLabels[i] : "Frame \(i + 1)"
                    contentBlocks.append([
                        "type": "text",
                        "text": "[\(label)]"
                    ])
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
                    "text": "\(text)\n\nThese labeled images show one continuous golf swing. Look carefully at the actual body positions in each phase. Describe what you see, then give your analysis."
                ])

                let systemPrompt = self.buildSystemPrompt(videoMode: true)

                // Include prior conversation messages for context (text-only, truncated)
                let priorMessages = Array(self.currentConversation.messages.dropLast(2))
                var apiMessages: [[String: Any]] = []
                var contextChars = 0
                let maxContextChars = 2000
                for msg in priorMessages {
                    guard !msg.content.isEmpty else { continue }
                    let content = String(msg.content.prefix(500))
                    if contextChars + content.count > maxContextChars { break }
                    apiMessages.append(["role": msg.role.rawValue, "content": content])
                    contextChars += content.count
                }
                apiMessages.append(["role": "user", "content": contentBlocks])
                let messages = apiMessages

                await MainActor.run { self.isAnalyzingVideo = false }
                self.chatLog("Sending to API...")
                let stream = ClaudeAPIService.streamMessage(
                    systemPrompt: systemPrompt,
                    messages: messages,
                    maxTokens: 4096
                )

                var chunkCount = 0
                for try await chunk in stream {
                    if Task.isCancelled { break }
                    chunkCount += 1
                    await MainActor.run {
                        let lastIndex = self.currentConversation.messages.count - 1
                        if lastIndex >= 0 {
                            self.currentConversation.messages[lastIndex].content += chunk
                        }
                    }
                }
                self.chatLog("Stream finished: \(chunkCount) chunks received")
            } catch {
                self.chatLog("Video stream ERROR: \(error.localizedDescription)")
                if !failed {
                    failed = true
                    await MainActor.run {
                        guard self.streamGeneration == myGeneration else { return }
                        if let last = self.currentConversation.messages.last, last.content.isEmpty {
                            self.currentConversation.messages.removeLast()
                        }
                        self.errorMessage = error.localizedDescription
                    }
                }
            }

            // Only reset if we're still the active stream
            await MainActor.run {
                guard self.streamGeneration == myGeneration else { return }
                self.cancelWatchdog()
                self.chatLog("Cleanup: isStreaming -> false (gen \(myGeneration), failed: \(failed))")
                self.isStreaming = false
                self.isAnalyzingVideo = false
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
        cancelWatchdog()
        streamTask?.cancel()
        streamTask = nil
        isStreaming = false
        isAnalyzingVideo = false
        cleanupEmptyMessages()
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
        var result: [[String: Any]] = []
        for msg in currentConversation.messages.dropLast() {
            guard !msg.content.isEmpty else { continue }
            // Merge consecutive same-role messages to satisfy alternating role requirement
            if let lastRole = result.last?["role"] as? String,
               lastRole == msg.role.rawValue,
               let lastContent = result.last?["content"] as? String {
                result[result.count - 1]["content"] = lastContent + "\n\n" + msg.content
            } else {
                result.append([
                    "role": msg.role.rawValue,
                    "content": msg.content
                ])
            }
        }
        return result
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

    private func startStreamWatchdog(generation: Int) {
        streamWatchdog?.cancel()
        streamWatchdog = Task { [weak self] in
            try? await Task.sleep(for: .seconds(90))
            guard let self, !Task.isCancelled else { return }
            await MainActor.run {
                guard self.streamGeneration == generation, self.isStreaming else { return }
                self.chatLog("Watchdog: isStreaming stuck for 90s, force-resetting (gen \(generation))")
                self.streamTask?.cancel()
                self.streamTask = nil
                self.isStreaming = false
                self.persistConversation()
            }
        }
    }

    private func cancelWatchdog() {
        streamWatchdog?.cancel()
        streamWatchdog = nil
    }

    private func chatLog(_ message: String) {
        let logFile = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("chat_debug.log")
        let timestamp = ISO8601DateFormatter().string(from: Date())
        let line = "[\(timestamp)] \(message)\n"
        if let data = line.data(using: .utf8) {
            if FileManager.default.fileExists(atPath: logFile.path) {
                if let handle = try? FileHandle(forWritingTo: logFile) {
                    handle.seekToEndOfFile()
                    handle.write(data)
                    handle.closeFile()
                }
            } else {
                try? data.write(to: logFile)
            }
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
