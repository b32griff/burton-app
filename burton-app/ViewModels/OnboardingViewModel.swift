import SwiftUI

@Observable
class OnboardingViewModel {
    var currentStep = 0
    var name = ""
    var handicapText = ""
    var selectedSkillLevel: SkillLevel = .beginner
    var selectedGoals: Set<ImprovementGoal> = []

    let totalSteps = 6

    let valuePages: [ValuePropositionPage] = [
        ValuePropositionPage(
            icon: "caddie.logo",
            title: "Your Personal\nAI Caddie",
            subtitle: "AI that actually understands your golf game",
            features: [
                .init(icon: "video.fill", text: "Upload swing videos for instant AI analysis"),
                .init(icon: "brain.head.profile", text: "Coaching that remembers your history"),
                .init(icon: "chart.line.uptrend.xyaxis", text: "Track your improvement over time"),
            ]
        ),
        ValuePropositionPage(
            icon: "list.bullet.clipboard",
            title: "Drills That\nActually Work",
            subtitle: "Practice plans built specifically for your swing",
            features: [
                .init(icon: "target", text: "Matched to your specific weaknesses"),
                .init(icon: "clock", text: "Sessions from 5 to 30 minutes"),
                .init(icon: "arrow.up.right", text: "Prioritized by what helps you most"),
            ]
        ),
        ValuePropositionPage(
            icon: "bubble.left.and.text.bubble.right.fill",
            title: "Chat With\nYour Caddie",
            subtitle: "Ask anything about your game, anytime",
            features: [
                .init(icon: "questionmark.bubble", text: "Answers to any golf question instantly"),
                .init(icon: "flag.fill", text: "Course management and strategy advice"),
                .init(icon: "brain", text: "Mental game tips from proven techniques"),
            ]
        ),
    ]

    var canProceed: Bool {
        switch currentStep {
        case 0, 1, 2, 3: true
        case 4: !selectedGoals.isEmpty
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
        let handicap = Double(handicapText)
        appState.completeOnboarding(
            name: name.trimmingCharacters(in: .whitespacesAndNewlines),
            handicap: handicap,
            skillLevel: selectedSkillLevel,
            goals: Array(selectedGoals)
        )
    }
}
