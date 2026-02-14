import SwiftUI

struct OnboardingContainerView: View {
    @Environment(AppState.self) private var appState
    @State private var viewModel = OnboardingViewModel()

    var body: some View {
        ZStack {
            AppGradient()

            VStack(spacing: 0) {
                // Progress dots (hide on paywall step)
                if viewModel.currentStep < 5 {
                    HStack(spacing: 8) {
                        ForEach(0..<5, id: \.self) { step in
                            Circle()
                                .fill(step <= viewModel.currentStep ? Color.white : Color.white.opacity(0.4))
                                .frame(width: 8, height: 8)
                        }
                    }
                    .padding(.top, 60)
                    .padding(.bottom, 20)
                }

                // Step content
                Group {
                    switch viewModel.currentStep {
                    case 0:
                        ValuePropositionView(
                            page: viewModel.valuePages[0],
                            onContinue: { viewModel.nextStep() }
                        )
                        .gesture(swipeGesture)
                    case 1:
                        ValuePropositionView(
                            page: viewModel.valuePages[1],
                            onContinue: { viewModel.nextStep() }
                        )
                        .gesture(swipeGesture)
                    case 2:
                        ValuePropositionView(
                            page: viewModel.valuePages[2],
                            onContinue: { viewModel.nextStep() }
                        )
                        .gesture(swipeGesture)
                    case 3:
                        SkillLevelStepView(viewModel: viewModel)
                    case 4:
                        GoalsStepView(viewModel: viewModel) {
                            viewModel.nextStep()
                        }
                    case 5:
                        PaywallView(
                            onSubscribed: {
                                viewModel.completeOnboarding(appState: appState)
                            },
                            onSkip: {
                                viewModel.completeOnboarding(appState: appState)
                            }
                        )
                    default:
                        EmptyView()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .animation(.easeInOut(duration: 0.3), value: viewModel.currentStep)
            }
        }
    }

    private var swipeGesture: some Gesture {
        DragGesture(minimumDistance: 50)
            .onEnded { value in
                if value.translation.width < -50 {
                    viewModel.nextStep()
                } else if value.translation.width > 50 {
                    viewModel.previousStep()
                }
            }
    }
}
