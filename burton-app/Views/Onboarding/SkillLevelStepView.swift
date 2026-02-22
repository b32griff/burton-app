import SwiftUI

struct SkillLevelStepView: View {
    @Bindable var viewModel: OnboardingViewModel
    @FocusState private var handicapFocused: Bool

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

            // Handicap input
            HStack(spacing: 12) {
                Text("Handicap")
                    .font(.headline)
                    .foregroundStyle(.white)
                TextField("Optional", text: $viewModel.handicapText)
                    .keyboardType(.decimalPad)
                    .focused($handicapFocused)
                    .multilineTextAlignment(.trailing)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                    .frame(width: 100)
                    .background(.white.opacity(0.15), in: RoundedRectangle(cornerRadius: 10))
                    .foregroundStyle(.white)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            Button("Done") { handicapFocused = false }
                                .foregroundStyle(.appAccent)
                        }
                    }
                    .onChange(of: viewModel.handicapText) {
                        if let hcp = Double(viewModel.handicapText) {
                            viewModel.selectedSkillLevel = SkillLevel.from(handicap: hcp)
                        }
                    }
            }
            .padding(.horizontal, 32)

            VStack(spacing: 12) {
                ForEach(SkillLevel.allCases) { level in
                    Button {
                        handicapFocused = false
                        Haptics.selection()
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
                    Haptics.light()
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
                    Haptics.light()
                    viewModel.nextStep()
                } label: {
                    Text("Continue")
                        .font(.headline)
                        .foregroundStyle(.appAccent)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.white, in: RoundedRectangle(cornerRadius: 14))
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 32)

            Spacer()
                .frame(height: 40)
        }
    }
}
