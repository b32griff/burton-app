import SwiftUI

struct GoalsStepView: View {
    @Bindable var viewModel: OnboardingViewModel
    var onComplete: () -> Void

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        VStack(spacing: 24) {
            Spacer()
                .frame(height: 20)

            Text("What do you want\nto improve?")
                .font(.largeTitle.bold())
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)

            Text("Select one or more goals.")
                .font(.body)
                .foregroundStyle(.white.opacity(0.9))

            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(ImprovementGoal.allCases) { goal in
                    let isSelected = viewModel.selectedGoals.contains(goal)
                    Button {
                        viewModel.toggleGoal(goal)
                    } label: {
                        VStack(spacing: 8) {
                            Image(systemName: goal.icon)
                                .font(.title2)
                            Text(goal.rawValue)
                                .font(.subheadline.weight(.medium))
                                .multilineTextAlignment(.center)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(
                            isSelected
                                ? Color.white.opacity(0.25)
                                : Color.white.opacity(0.1),
                            in: RoundedRectangle(cornerRadius: 12)
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .strokeBorder(
                                    isSelected ? Color.white : Color.clear,
                                    lineWidth: 2
                                )
                        )
                        .foregroundStyle(.white)
                    }
                }
            }
            .padding(.horizontal, 24)

            Spacer()

            HStack(spacing: 16) {
                Button {
                    viewModel.previousStep()
                } label: {
                    Text("Back")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.white.opacity(0.2), in: RoundedRectangle(cornerRadius: 14))
                }

                Button {
                    onComplete()
                } label: {
                    Text("Let's Go!")
                        .font(.headline)
                        .foregroundStyle(.golfGreen)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.white, in: RoundedRectangle(cornerRadius: 14))
                }
                .disabled(!viewModel.canProceed)
                .opacity(viewModel.canProceed ? 1.0 : 0.6)
            }
            .padding(.horizontal, 32)

            Spacer()
                .frame(height: 40)
        }
    }
}
