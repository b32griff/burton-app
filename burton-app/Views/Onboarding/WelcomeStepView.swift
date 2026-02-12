import SwiftUI

struct WelcomeStepView: View {
    @Bindable var viewModel: OnboardingViewModel

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            Image(systemName: "figure.golf")
                .font(.system(size: 80))
                .foregroundStyle(.white)

            Text("Welcome to\nSwing Coach")
                .font(.largeTitle.bold())
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)

            Text("Your personal AI-powered golf improvement companion. Get expert tips, practice drills, and track your progress.")
                .font(.body)
                .foregroundStyle(.white.opacity(0.9))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)

            Spacer()

            VStack(spacing: 12) {
                TextField("Your name (optional)", text: $viewModel.name)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal, 32)

                Button {
                    viewModel.nextStep()
                } label: {
                    Text("Get Started")
                        .font(.headline)
                        .foregroundStyle(.golfGreen)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.white, in: RoundedRectangle(cornerRadius: 14))
                }
                .padding(.horizontal, 32)
            }

            Spacer()
                .frame(height: 40)
        }
    }
}
