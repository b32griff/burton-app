import SwiftUI

@Observable
class OnboardingViewModel {
    var currentStep = 0
    var name = ""
    var selectedSkillLevel: SkillLevel = .beginner
    var selectedGoals: Set<ImprovementGoal> = []

    let totalSteps = 3

    var canProceed: Bool {
        switch currentStep {
        case 0: true
        case 1: true
        case 2: !selectedGoals.isEmpty
        default: true
        }
    }

    func nextStep() {
        if currentStep < totalSteps - 1 {
            withAnimation(.easeInOut(duration: 0.3)) {
                currentStep += 1
            }
        }
    }

    func previousStep() {
        if currentStep > 0 {
            withAnimation(.easeInOut(duration: 0.3)) {
                currentStep -= 1
            }
        }
    }

    func toggleGoal(_ goal: ImprovementGoal) {
        if selectedGoals.contains(goal) {
            selectedGoals.remove(goal)
        } else {
            selectedGoals.insert(goal)
        }
    }

    func completeOnboarding(appState: AppState) {
        appState.completeOnboarding(
            name: name.trimmingCharacters(in: .whitespacesAndNewlines),
            skillLevel: selectedSkillLevel,
            goals: Array(selectedGoals)
        )
    }
}
