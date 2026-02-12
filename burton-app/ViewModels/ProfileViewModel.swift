import Foundation

@Observable
class ProfileViewModel {
    var name: String = ""
    var handicap: String = ""
    var selectedSkillLevel: SkillLevel = .beginner
    var selectedGoals: Set<ImprovementGoal> = []

    func loadFrom(profile: UserProfile) {
        name = profile.name
        handicap = profile.handicap.map { String($0) } ?? ""
        selectedSkillLevel = profile.skillLevel
        selectedGoals = Set(profile.goals)
    }

    func save(to appState: AppState) {
        appState.updateProfile(
            name: name.trimmingCharacters(in: .whitespacesAndNewlines),
            handicap: Double(handicap),
            skillLevel: selectedSkillLevel,
            goals: Array(selectedGoals)
        )
    }

    func toggleGoal(_ goal: ImprovementGoal) {
        if selectedGoals.contains(goal) {
            selectedGoals.remove(goal)
        } else {
            selectedGoals.insert(goal)
        }
    }
}
