import Foundation

enum MessageRole: String, Codable {
    case user
    case assistant
}

struct ChatMessage: Identifiable, Codable {
    let id: UUID
    let role: MessageRole
    var content: String
    let timestamp: Date
    var imageReferences: [String]

    init(id: UUID = UUID(), role: MessageRole, content: String, timestamp: Date = Date(), imageReferences: [String] = []) {
        self.id = id
        self.role = role
        self.content = content
        self.timestamp = timestamp
        self.imageReferences = imageReferences
    }
}
