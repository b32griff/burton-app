import Foundation

struct UserDefaultsManager {
    private static let profileKey = "user_profile"
    private static let practiceLogKey = "practice_log"

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

    // MARK: - Practice Log

    static func savePracticeLog(_ entries: [PracticeLogEntry]) {
        if let data = try? JSONEncoder().encode(entries) {
            UserDefaults.standard.set(data, forKey: practiceLogKey)
        }
    }

    static func loadPracticeLog() -> [PracticeLogEntry] {
        guard let data = UserDefaults.standard.data(forKey: practiceLogKey) else { return [] }
        return (try? JSONDecoder().decode([PracticeLogEntry].self, from: data)) ?? []
    }

    static func addPracticeEntry(_ entry: PracticeLogEntry) {
        var entries = loadPracticeLog()
        entries.insert(entry, at: 0)
        savePracticeLog(entries)
    }

    static func deletePracticeEntry(id: UUID) {
        var entries = loadPracticeLog()
        entries.removeAll { $0.id == id }
        savePracticeLog(entries)
    }

    // MARK: - Reset

    static func resetAll() {
        UserDefaults.standard.removeObject(forKey: profileKey)
        UserDefaults.standard.removeObject(forKey: practiceLogKey)
    }
}
