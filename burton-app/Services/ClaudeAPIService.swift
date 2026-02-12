import Foundation

struct ClaudeAPIService {
    private static let apiURL = URL(string: "https://api.anthropic.com/v1/messages")!
    private static let model = "claude-sonnet-4-20250514"
    private static let maxTokens = 2048

    // MARK: - Streaming

    static func streamMessage(
        apiKey: String,
        systemPrompt: String,
        messages: [[String: Any]]
    ) -> AsyncThrowingStream<String, Error> {
        AsyncThrowingStream { continuation in
            let task = Task {
                do {
                    let request = try buildRequest(
                        apiKey: apiKey,
                        systemPrompt: systemPrompt,
                        messages: messages,
                        stream: true
                    )

                    let (bytes, response) = try await URLSession.shared.bytes(for: request)

                    guard let httpResponse = response as? HTTPURLResponse else {
                        throw APIError.invalidResponse
                    }

                    guard httpResponse.statusCode == 200 else {
                        var errorBody = ""
                        for try await line in bytes.lines {
                            errorBody += line
                        }
                        throw APIError.httpError(httpResponse.statusCode, errorBody)
                    }

                    for try await line in bytes.lines {
                        if Task.isCancelled { break }

                        guard line.hasPrefix("data: ") else { continue }
                        let jsonString = String(line.dropFirst(6))

                        guard jsonString != "[DONE]",
                              let data = jsonString.data(using: .utf8),
                              let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                              let type = json["type"] as? String
                        else { continue }

                        if type == "content_block_delta",
                           let delta = json["delta"] as? [String: Any],
                           let text = delta["text"] as? String {
                            continuation.yield(text)
                        }

                        if type == "message_stop" {
                            break
                        }

                        if type == "error",
                           let error = json["error"] as? [String: Any],
                           let message = error["message"] as? String {
                            throw APIError.apiError(message)
                        }
                    }

                    continuation.finish()
                } catch {
                    continuation.finish(throwing: error)
                }
            }

            continuation.onTermination = { _ in
                task.cancel()
            }
        }
    }

    // MARK: - Vision (non-streaming)

    static func sendMessageWithImages(
        apiKey: String,
        systemPrompt: String,
        textContent: String,
        imageDataArray: [Data]
    ) async throws -> String {
        var contentBlocks: [[String: Any]] = []

        for imageData in imageDataArray {
            let base64 = imageData.base64EncodedString()
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
            "text": textContent
        ])

        let messages: [[String: Any]] = [
            ["role": "user", "content": contentBlocks]
        ]

        let request = try buildRequest(
            apiKey: apiKey,
            systemPrompt: systemPrompt,
            messages: messages,
            stream: false
        )

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        guard httpResponse.statusCode == 200 else {
            let body = String(data: data, encoding: .utf8) ?? "Unknown error"
            throw APIError.httpError(httpResponse.statusCode, body)
        }

        guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
              let content = json["content"] as? [[String: Any]],
              let firstBlock = content.first,
              let text = firstBlock["text"] as? String
        else {
            throw APIError.parseError
        }

        return text
    }

    // MARK: - Simple non-streaming request (for internal tasks like titling/profiling)

    static func sendSimpleMessage(
        apiKey: String,
        systemPrompt: String,
        userMessage: String
    ) async throws -> String {
        let messages: [[String: Any]] = [
            ["role": "user", "content": userMessage]
        ]

        let request = try buildRequest(
            apiKey: apiKey,
            systemPrompt: systemPrompt,
            messages: messages,
            stream: false
        )

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        guard httpResponse.statusCode == 200 else {
            let body = String(data: data, encoding: .utf8) ?? "Unknown error"
            throw APIError.httpError(httpResponse.statusCode, body)
        }

        guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
              let content = json["content"] as? [[String: Any]],
              let firstBlock = content.first,
              let text = firstBlock["text"] as? String
        else {
            throw APIError.parseError
        }

        return text
    }

    // MARK: - Validate API Key

    static func validateAPIKey(_ key: String) async -> Bool {
        do {
            let messages: [[String: Any]] = [
                ["role": "user", "content": "Hi"]
            ]
            let request = try buildRequest(
                apiKey: key,
                systemPrompt: "Respond with OK",
                messages: messages,
                stream: false,
                maxTokens: 10
            )
            let (_, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else { return false }
            return httpResponse.statusCode == 200
        } catch {
            return false
        }
    }

    // MARK: - Private

    private static func buildRequest(
        apiKey: String,
        systemPrompt: String,
        messages: [[String: Any]],
        stream: Bool,
        maxTokens: Int = maxTokens
    ) throws -> URLRequest {
        var request = URLRequest(url: apiURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        request.setValue(apiKey, forHTTPHeaderField: "x-api-key")
        request.setValue("2023-06-01", forHTTPHeaderField: "anthropic-version")

        var body: [String: Any] = [
            "model": model,
            "max_tokens": maxTokens,
            "system": systemPrompt,
            "messages": messages,
            "stream": stream
        ]

        if stream {
            body["stream"] = true
        }

        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        return request
    }

    enum APIError: LocalizedError {
        case invalidResponse
        case httpError(Int, String)
        case apiError(String)
        case parseError

        var errorDescription: String? {
            switch self {
            case .invalidResponse:
                return "Invalid response from server"
            case .httpError(let code, let body):
                if code == 401 {
                    return "Invalid API key. Please check your key in Settings."
                }
                return "Server error (\(code)): \(body)"
            case .apiError(let message):
                return "API error: \(message)"
            case .parseError:
                return "Failed to parse response"
            }
        }
    }
}
