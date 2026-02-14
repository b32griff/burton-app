import SwiftUI

struct SkillLevelStepView: View {
    @Bindable var viewModel: OnboardingViewModel

    var body: some View {
        VStack(spacing: 24) {
            Spacer()
                .frame(height: 20)

            Text("What's your\nskill level?")
                .font(.largeTitle.bold())
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)

            Text("This helps us personalize your tips and drills.")
                .font(.body)
                .foregroundStyle(.white.opacity(0.9))

            VStack(spacing: 12) {
                ForEach(SkillLevel.allCases) { level in
                    Button {
                        viewModel.selectedSkillLevel = level
                    } label: {
                        HStack(spacing: 16) {
                            Image(systemName: level.icon)
                                .font(.title2)
                                .frame(width: 32)

                            VStack(alignment: .leading, spacing: 2) {
                                Text(level.rawValue)
                                    .font(.headline)
                                Text(level.description)
                                    .font(.caption)
                                    .opacity(0.8)
                            }

                            Spacer()

                            if viewModel.selectedSkillLevel == level {
                                Image(systemName: "checkmark.circle.fill")
                                    .font(.title2)
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(
                            viewModel.selectedSkillLevel == level
                                ? Color.white.opacity(0.25)
                                : Color.white.opacity(0.1),
                            in: RoundedRectangle(cornerRadius: 12)
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
                    viewModel.nextStep()
                } label: {
                    Text("Continue")
                        .font(.headline)
                        .foregroundStyle(.appAccent)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.white, in: RoundedRectangle(cornerRadius: 14))
                }
            }
            .padding(.horizontal, 32)

            Spacer()
                .frame(height: 40)
        }
    }
}
