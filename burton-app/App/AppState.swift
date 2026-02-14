import SwiftUI

@Observable
class AppState {
    var userProfile: UserProfile
    var conversations: [Conversation]
    var swingProfile: SwingProfile

    var hasCompletedOnboarding: Bool {
        userProfile.hasCompletedOnboarding
    }

    init() {
        self.userProfile = UserDefaultsManager.loadProfile() ?? .empty
        self.conversations = UserDefaultsManager.loadConversations()
        self.swingProfile = UserDefaultsManager.loadSwingProfile()
    }

    func completeOnboarding(name: String, skillLevel: SkillLevel, goals: [ImprovementGoal]) {
        userProfile.name = name
        userProfile.skillLevel = skillLevel
        userProfile.goals = goals
        userProfile.hasCompletedOnboarding = true
        saveProfile()
    }

    func updateProfile(name: String, handicap: Double?, skillLevel: SkillLevel, goals: [ImprovementGoal]) {
        userProfile.name = name
        userProfile.handicap = handicap
        userProfile.skillLevel = skillLevel
        userProfile.goals = goals
        saveProfile()
    }

    // MARK: - Conversations

    func addConversation(_ conversation: Conversation) {
        conversations.insert(conversation, at: 0)
        saveConversations()
    }

    func updateConversation(_ conversation: Conversation) {
        if let index = conversations.firstIndex(where: { $0.id == conversation.id }) {
            conversations[index] = conversation
        }
        saveConversations()
    }

    func deleteConversation(id: UUID) {
        // Clean up thumbnail files for this conversation
        if let conversation = conversations.first(where: { $0.id == id }) {
            for message in conversation.messages {
                for path in message.imageReferences {
                    try? FileManager.default.removeItem(atPath: path)
                }
            }
        }
        conversations.removeAll { $0.id == id }
        saveConversations()
    }

    // MARK: - Swing Profile

    func updateSwingProfile(_ profile: SwingProfile) {
        swingProfile = profile
        UserDefaultsManager.saveSwingProfile(profile)
    }

    // MARK: - Reset

    func resetOnboarding() {
        // Clean up thumbnail files
        let thumbnailDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("thumbnails", isDirectory: true)
        try? FileManager.default.removeItem(at: thumbnailDir)

        // Clean up debug logs
        let docsDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        try? FileManager.default.removeItem(at: docsDir.appendingPathComponent("chat_debug.log"))
        try? FileManager.default.removeItem(at: docsDir.appendingPathComponent("swing_memory_debug.log"))

        UserDefaultsManager.resetAll()
        userProfile = .empty
        conversations = []
        swingProfile = .empty
    }

    private func saveProfile() {
        UserDefaultsManager.saveProfile(userProfile)
    }

    private func saveConversations() {
        UserDefaultsManager.saveConversations(conversations)
    }
}
