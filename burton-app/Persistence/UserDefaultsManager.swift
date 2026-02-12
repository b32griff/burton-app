import Foundation

struct UserDefaultsManager {
    private static let profileKey = "user_profile"
    private static let conversationsKey = "conversations"
    private static let swingProfileKey = "swing_profile"
    private static let maxConversations = 50

    // MARK: - User Profile

    static func saveProfile(_ profile: UserProfile) {
        if let data = try? JSONEncoder().encode(profile) {
            UserDefaults.standard.set(data, forKey: profileKey)
        }
    }

    static func loadProfile() -> UserProfile? {
        guard let data = UserDefaults.standard.data(forKey: profileKey) else { return nil }
        return try? JSONDecoder().decode(UserProfile.self, from: data)
    }

    // MARK: - Conversations

    static func saveConversations(_ conversations: [Conversation]) {
        var toSave = conversations
        if toSave.count > maxConversations {
            toSave = Array(toSave.sorted { $0.updatedAt > $1.updatedAt }.prefix(maxConversations))
        }
        if let data = try? JSONEncoder().encode(toSave) {
            UserDefaults.standard.set(data, forKey: conversationsKey)
        }
    }

    static func loadConversations() -> [Conversation] {
        guard let data = UserDefaults.standard.data(forKey: conversationsKey) else { return [] }
        return (try? JSONDecoder().decode([Conversation].self, from: data)) ?? []
    }

    // MARK: - Swing Profile

    static func saveSwingProfile(_ profile: SwingProfile) {
        if let data = try? JSONEncoder().encode(profile) {
            UserDefaults.standard.set(data, forKey: swingProfileKey)
        }
    }

    static func loadSwingProfile() -> SwingProfile {
        guard let data = UserDefaults.standard.data(forKey: swingProfileKey) else { return .empty }
        return (try? JSONDecoder().decode(SwingProfile.self, from: data)) ?? .empty
    }

    // MARK: - Reset

    static func resetAll() {
        UserDefaults.standard.removeObject(forKey: profileKey)
        UserDefaults.standard.removeObject(forKey: conversationsKey)
        UserDefaults.standard.removeObject(forKey: swingProfileKey)
    }
}
