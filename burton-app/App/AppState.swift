import SwiftUI

@Observable
class AppState {
    var userProfile: UserProfile
    var practiceLog: [PracticeLogEntry]

    var hasCompletedOnboarding: Bool {
        userProfile.hasCompletedOnboarding
    }

    init() {
        self.userProfile = UserDefaultsManager.loadProfile() ?? .empty
        self.practiceLog = UserDefaultsManager.loadPracticeLog()
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

    func addPracticeEntry(_ entry: PracticeLogEntry) {
        practiceLog.insert(entry, at: 0)
        UserDefaultsManager.savePracticeLog(practiceLog)
    }

    func deletePracticeEntry(id: UUID) {
        practiceLog.removeAll { $0.id == id }
        UserDefaultsManager.savePracticeLog(practiceLog)
    }

    func resetOnboarding() {
        UserDefaultsManager.resetAll()
        userProfile = .empty
        practiceLog = []
    }

    private func saveProfile() {
        UserDefaultsManager.saveProfile(userProfile)
    }
}
