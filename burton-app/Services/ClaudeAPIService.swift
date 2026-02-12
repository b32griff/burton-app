import UIKit
import Foundation

struct ClaudeAPIService {
    static var backendURL = URL(string: "https://burton-app.vercel.app/api/chat")!

    private static var deviceId: String {
        UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
    }

    // MARK: - Streaming

    static func streamMessage(
        systemPrompt: String,
        messages: [[String: Any]]
    ) -> AsyncThrowingStream<String, Error> {
        AsyncThrowingStream { continuation in
            let task = Task {
                do {
                    let request = try buildRequest(
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
        systemPrompt: String,
        userMessage: String
    ) async throws -> String {
        let messages: [[String: Any]] = [
            ["role": "user", "content": userMessage]
        ]

        let request = try buildRequest(
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

    // MARK: - Private

    private static func buildRequest(
        systemPrompt: String,
        messages: [[String: Any]],
        stream: Bool,
        maxTokens: Int = 2048
    ) throws -> URLRequest {
        var request = URLRequest(url: backendURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        request.setValue(deviceId, forHTTPHeaderField: "x-device-id")

        let body: [String: Any] = [
            "system": systemPrompt,
            "messages": messages,
            "stream": stream,
            "max_tokens": maxTokens
        ]

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
                return "Unable to connect. Please check your internet connection."
            case .httpError(let code, let body):
                if code == 429 {
                    return "You've reached the message limit. Please try again later."
                }
                return "Server error (\(code)): \(body)"
            case .apiError(let message):
                return "AI error: \(message)"
            case .parseError:
                return "Failed to parse response"
            }
        }
    }
}
