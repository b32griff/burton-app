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
    var stagedClubType: ClubType = .iron
    var stagedCameraAngle: CameraAngle = .dtl
    var stagedShotMiss: ShotMiss = .notSure

    // Upgrade prompt (watched by ChatView to present paywall)
    var showUpgradePrompt = false

    // Incremented when the user sends a message — triggers one scroll-to-bottom
    var scrollToBottomTrigger = 0

    private var streamTask: Task<Void, Never>?
    private var streamGeneration = 0 // prevents old tasks from resetting isStreaming
    private var streamWatchdog: Task<Void, Never>?
    private var appState: AppState?
    private var memoryManager: SwingMemoryManager?
    private var subscriptionManager: SubscriptionManager?
    private var hasConfigured = false

    init(conversation: Conversation? = nil) {
        self.currentConversation = conversation ?? Conversation()
    }

    func configure(appState: AppState, memoryManager: SwingMemoryManager, subscriptionManager: SubscriptionManager) {
        self.appState = appState
        self.memoryManager = memoryManager
        self.subscriptionManager = subscriptionManager

        guard !hasConfigured else { return }
        hasConfigured = true

        cleanupEmptyMessages()
        // Reset stuck streaming state from previous session
        if isStreaming {
            isStreaming = false
            streamTask?.cancel()
            streamTask = nil
        }

        // Retroactively title and clean up existing untitled conversations
        retroTitleUntitledConversations()
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
            // Gate: check video analysis limit
            if let sm = subscriptionManager, !sm.canAnalyzeVideo {
                showUpgradePrompt = true
                inputText = messageText // restore text so user doesn't lose it
                return
            }

            let thumbnailPath = stagedThumbnailPath
            let clubType = stagedClubType
            let cameraAngle = stagedCameraAngle
            let shotMiss = stagedShotMiss
            stagedVideoURL = nil
            stagedThumbnailPath = nil
            stagedClubType = .iron
            stagedCameraAngle = .dtl
            stagedShotMiss = .notSure
            sendVideoWithMessage(url: videoURL, text: messageText, thumbnailPath: thumbnailPath, clubType: clubType, cameraAngle: cameraAngle, shotMiss: shotMiss)
            return
        }

        // Gate: check chat message limit
        if let sm = subscriptionManager, !sm.canSendChat {
            showUpgradePrompt = true
            inputText = messageText
            return
        }

        let userMessage = ChatMessage(role: .user, content: messageText)
        currentConversation.messages.append(userMessage)
        currentConversation.updatedAt = Date()
        scrollToBottomTrigger += 1

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
                    maxTokens: 800,
                    taskType: "chat"
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
                    self.subscriptionManager?.incrementChatMessage()
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
        stagedClubType = .iron
        stagedCameraAngle = .dtl
        stagedShotMiss = .notSure
    }

    // MARK: - Video Analysis (internal)

    private func sendVideoWithMessage(url: URL, text: String, thumbnailPath: String?, clubType: ClubType, cameraAngle: CameraAngle, shotMiss: ShotMiss = .notSure) {
        errorMessage = nil
        streamGeneration += 1
        let myGeneration = streamGeneration
        isStreaming = true
        startStreamWatchdog(generation: myGeneration)
        chatLog("Video send started (gen \(myGeneration))")

        // Save video permanently
        let savedVideoPath = saveVideo(from: url)

        let userMessage = ChatMessage(
            role: .user,
            content: text,
            imageReferences: thumbnailPath.map { [$0] } ?? [],
            videoPath: savedVideoPath
        )
        currentConversation.messages.append(userMessage)
        currentConversation.updatedAt = Date()
        scrollToBottomTrigger += 1

        let assistantMessage = ChatMessage(role: .assistant, content: "")
        currentConversation.messages.append(assistantMessage)

        streamTask = Task { [weak self] in
            guard let self else { return }

            var failed = false

            do {
                await MainActor.run { self.isAnalyzingVideo = true }
                self.chatLog("Extracting frames...")
                let frames = try await VideoFrameExtractor.extractKeyFrames(from: url)
                self.chatLog("Got \(frames.count) frames, club=\(clubType.rawValue), sizes: \(frames.map(\.count))")

                guard !frames.isEmpty else {
                    await MainActor.run {
                        guard self.streamGeneration == myGeneration else { return }
                        self.currentConversation.messages.removeLast()
                        self.errorMessage = "Could not extract frames from video."
                    }
                    failed = true
                    throw ClaudeAPIService.APIError.parseError
                }

                // Use the phase labels from the extractor (matches weighted frame positions)
                let phaseLabels = VideoFrameExtractor.phaseLabels

                // Build content blocks with labels interleaved
                var contentBlocks: [[String: Any]] = []

                // Tell the AI what club the user selected
                contentBlocks.append([
                    "type": "text",
                    "text": "[CLUB: \(clubType.rawValue) — confirmed by the golfer. Do NOT attempt to identify the club yourself. Use \(clubType.rawValue) mechanics as your reference for this analysis.]"
                ])

                // Tell the AI what camera angle was used
                contentBlocks.append([
                    "type": "text",
                    "text": "[CAMERA ANGLE: \(cameraAngle.rawValue) — \(cameraAngle.analysisContext) Focus your analysis on what this angle reveals.]"
                ])

                // Tell the AI the golfer's typical miss
                contentBlocks.append([
                    "type": "text",
                    "text": "[MISS: \(shotMiss.rawValue) — \(shotMiss.analysisContext)]"
                ])

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
                let missNote = shotMiss == .notSure ? "" : " Their typical miss: \(shotMiss.rawValue)."
                contentBlocks.append([
                    "type": "text",
                    "text": "\(text)\n\nThe golfer confirmed they are using a \(clubType.rawValue). Camera angle: \(cameraAngle.rawValue).\(missNote) These labeled images show one continuous golf swing. Analyze using \(clubType.rawValue) mechanics as the reference standard. Focus on what the \(cameraAngle.rawValue) angle reveals."
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
                    maxTokens: 1500,
                    taskType: "video_analysis"
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
                    self.subscriptionManager?.incrementVideoAnalysis()
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
        // Cancel any active stream before switching
        if isStreaming {
            cancelWatchdog()
            streamTask?.cancel()
            streamTask = nil
            isStreaming = false
            isAnalyzingVideo = false
        }
        cleanupEmptyMessages()
        persistConversation()
        clearStagedVideo()
        currentConversation = Conversation()
        inputText = ""
        errorMessage = nil
        subscriptionManager?.incrementConversation()
    }

    func loadConversation(_ conversation: Conversation) {
        // Cancel any active stream before switching
        if isStreaming {
            cancelWatchdog()
            streamTask?.cancel()
            streamTask = nil
            isStreaming = false
            isAnalyzingVideo = false
        }
        cleanupEmptyMessages()
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

        let includeSwingMemory = subscriptionManager?.canAccessSwingMemory ?? true

        let recentSummaries: [String] = includeSwingMemory
            ? appState.conversations.prefix(3).compactMap(\.summary)
            : []

        return SystemPromptBuilder.buildCompact(
            userProfile: appState.userProfile,
            swingProfile: includeSwingMemory ? (memoryManager?.swingProfile ?? .empty) : .empty,
            recentConversationSummaries: recentSummaries,
            videoAnalysisMode: videoMode
        )
    }

    private func buildAPIMessages() -> [[String: Any]] {
        var result: [[String: Any]] = []
        for msg in currentConversation.messages.dropLast() {
            guard !msg.content.isEmpty else { continue }

            var content = msg.content
            // If this user message had video frames attached, annotate so Claude knows
            if msg.role == .user && (msg.videoPath != nil || !msg.imageReferences.isEmpty) {
                content = "[Video analysis was included with this message.]\n\n" + content
            }

            // Merge consecutive same-role messages to satisfy alternating role requirement
            if let lastRole = result.last?["role"] as? String,
               lastRole == msg.role.rawValue,
               let lastContent = result.last?["content"] as? String {
                result[result.count - 1]["content"] = lastContent + "\n\n" + content
            } else {
                result.append([
                    "role": msg.role.rawValue,
                    "content": content
                ])
            }
        }

        // Trim to last 6 messages (3 user + 3 assistant turns) to control input token costs
        if result.count > 6 {
            result = Array(result.suffix(6))
            // Ensure the first message is from the user (API requirement)
            if let first = result.first, (first["role"] as? String) == "assistant" {
                result.removeFirst()
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
        guard !currentConversation.messages.isEmpty,
              currentConversation.title == "New Conversation"
        else { return }

        // Find first user message, or fall back to assistant response for video-only sends
        let userMsg = currentConversation.messages.first { $0.role == .user && !$0.content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
        let fallback = currentConversation.messages.first { $0.role == .assistant && !$0.content.isEmpty }
        let firstUserMessage = (userMsg ?? fallback)?.content ?? ""
        guard !firstUserMessage.isEmpty else { return }

        Task {
            do {
                let title = try await ClaudeAPIService.sendSimpleMessage(
                    systemPrompt: "Generate a 3-6 word title for this golf chat. ONLY the title, no quotes or markdown.",
                    userMessage: firstUserMessage,
                    maxTokens: 20,
                    taskType: "title"
                )

                await MainActor.run {
                    self.currentConversation.title = Self.cleanTitle(title)
                    self.persistConversation()
                }
            } catch {
                // Title generation is best-effort
            }
        }
    }

    /// Retroactively generates titles for untitled conversations and cleans up markdown in existing titles
    private func retroTitleUntitledConversations() {
        guard let appState else { return }

        // First pass: clean up any existing titles with artifacts or regenerate bad ones
        for conversation in appState.conversations {
            let title = conversation.title
            let cleaned = Self.cleanTitle(title)
            if cleaned != title {
                var updated = conversation
                updated.title = cleaned.isEmpty ? "New Conversation" : cleaned
                appState.updateConversation(updated)
            }
        }

        // Second pass: generate titles for untitled conversations or ones with sentence-like titles
        let needsTitle = appState.conversations.filter { conv in
            guard !conv.messages.isEmpty else { return false }
            let title = conv.title
            return title == "New Conversation" || title.count > 40 || title.hasPrefix("I ")
        }

        for conversation in needsTitle {
            // Find first user message with actual content
            let userMessage = conversation.messages
                .first { $0.role == .user && !$0.content.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
            // Fall back to first assistant message if user sent only video
            let contextMessage = userMessage ?? conversation.messages
                .first { $0.role == .assistant && !$0.content.isEmpty }

            guard let message = contextMessage, !message.content.isEmpty else { continue }

            let conversationId = conversation.id
            let messageContent = String(message.content.prefix(300))

            Task {
                do {
                    let title = try await ClaudeAPIService.sendSimpleMessage(
                        systemPrompt: "Generate a 3-6 word title for this golf chat. ONLY the title, no quotes or markdown.",
                        userMessage: messageContent,
                        maxTokens: 20,
                        taskType: "title"
                    )

                    await MainActor.run {
                        guard var conv = appState.conversations.first(where: { $0.id == conversationId }) else { return }
                        let cleaned = Self.cleanTitle(title)
                        if !cleaned.isEmpty {
                            conv.title = cleaned
                            appState.updateConversation(conv)
                        }
                    }
                } catch {
                    // Best-effort
                }
            }
        }
    }

    /// Strips markdown artifacts, thinking tags, and trims the title
    private static func cleanTitle(_ raw: String) -> String {
        var title = raw.trimmingCharacters(in: .whitespacesAndNewlines)
        // Remove <thinking>...</thinking> blocks
        if let range = title.range(of: "<thinking>[\\s\\S]*?</thinking>", options: .regularExpression) {
            title = title.replacingCharacters(in: range, with: "")
        }
        // Remove any remaining <thinking> or </thinking> tags
        title = title.replacingOccurrences(of: "<thinking>", with: "")
        title = title.replacingOccurrences(of: "</thinking>", with: "")
        // Remove leading markdown heading markers
        while title.hasPrefix("#") {
            title = String(title.dropFirst())
        }
        // Remove surrounding quotes
        if title.hasPrefix("\"") && title.hasSuffix("\"") {
            title = String(title.dropFirst().dropLast())
        }
        // Remove trailing ellipsis
        while title.hasSuffix("...") {
            title = String(title.dropLast(3))
        }
        while title.hasSuffix("…") {
            title = String(title.dropLast())
        }
        title = title.trimmingCharacters(in: .whitespacesAndNewlines)
        // Truncate
        return String(title.prefix(50))
    }

    private func saveVideo(from url: URL) -> String? {
        let videoDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("videos", isDirectory: true)
        try? FileManager.default.createDirectory(at: videoDir, withIntermediateDirectories: true)

        let fileName = "\(UUID().uuidString).\(url.pathExtension)"
        let destURL = videoDir.appendingPathComponent(fileName)

        do {
            try FileManager.default.copyItem(at: url, to: destURL)
            return destURL.path
        } catch {
            return nil
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
            try? await Task.sleep(for: .seconds(150))
            guard let self, !Task.isCancelled else { return }
            await MainActor.run {
                guard self.streamGeneration == generation, self.isStreaming else { return }
                self.chatLog("Watchdog: isStreaming stuck for 150s, force-resetting (gen \(generation))")
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
                    defer { handle.closeFile() }
                    handle.seekToEndOfFile()
                    handle.write(data)
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
                    systemPrompt: "Summarize this golf coaching conversation in 1-2 sentences. ONLY the summary.",
                    userMessage: messagesText,
                    maxTokens: 150,
                    taskType: "summary"
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
