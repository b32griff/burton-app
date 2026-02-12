import SwiftUI

struct OnboardingContainerView: View {
    @Environment(AppState.self) private var appState
    @State private var viewModel = OnboardingViewModel()

    var body: some View {
        ZStack {
            GolfGradient()

            VStack(spacing: 0) {
                // Progress dots
                HStack(spacing: 8) {
                    ForEach(0..<viewModel.totalSteps, id: \.self) { step in
                        Circle()
                            .fill(step <= viewModel.currentStep ? Color.white : Color.white.opacity(0.4))
                            .frame(width: 8, height: 8)
                    }
                }
                .padding(.top, 60)
                .padding(.bottom, 20)

                // Step content
                Group {
                    switch viewModel.currentStep {
                    case 0:
                        WelcomeStepView(viewModel: viewModel)
                    case 1:
                        SkillLevelStepView(viewModel: viewModel)
                    default:
                        GoalsStepView(viewModel: viewModel) {
                            viewModel.completeOnboarding(appState: appState)
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .animation(.easeInOut(duration: 0.3), value: viewModel.currentStep)
            }
        }
    }
}
