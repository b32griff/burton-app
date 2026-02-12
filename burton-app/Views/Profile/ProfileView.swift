import SwiftUI

struct ProfileView: View {
    @Environment(AppState.self) private var appState
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel = ProfileViewModel()
    @State private var showResetConfirmation = false

    private let goalColumns = [
        GridItem(.flexible(), spacing: 10),
        GridItem(.flexible(), spacing: 10)
    ]

    var body: some View {
        Form {
            Section("Personal Info") {
                TextField("Name", text: $viewModel.name)
                TextField("Handicap (optional)", text: $viewModel.handicap)
                    .keyboardType(.decimalPad)
            }

            Section("Skill Level") {
                Picker("Skill Level", selection: $viewModel.selectedSkillLevel) {
                    ForEach(SkillLevel.allCases) { level in
                        Text(level.rawValue).tag(level)
                    }
                }
            }

            Section("Improvement Goals") {
                LazyVGrid(columns: goalColumns, spacing: 10) {
                    ForEach(ImprovementGoal.allCases) { goal in
                        let isSelected = viewModel.selectedGoals.contains(goal)
                        Button {
                            viewModel.toggleGoal(goal)
                        } label: {
                            VStack(spacing: 4) {
                                Image(systemName: goal.icon)
                                    .font(.title3)
                                Text(goal.rawValue)
                                    .font(.caption2)
                                    .multilineTextAlignment(.center)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background(
                                isSelected ? Color.golfGreen.opacity(0.15) : Color.clear,
                                in: RoundedRectangle(cornerRadius: 8)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .strokeBorder(isSelected ? Color.golfGreen : Color.gray.opacity(0.3))
                            )
                            .foregroundStyle(isSelected ? .golfGreen : .primary)
                        }
                    }
                }
            }

            Section {
                Button("Reset Onboarding", role: .destructive) {
                    showResetConfirmation = true
                }
            }
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") { dismiss() }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Save") {
                    viewModel.save(to: appState)
                    dismiss()
                }
                .font(.headline)
            }
        }
        .onAppear {
            viewModel.loadFrom(profile: appState.userProfile)
        }
        .alert("Reset Onboarding?", isPresented: $showResetConfirmation) {
            Button("Reset", role: .destructive) {
                appState.resetOnboarding()
                dismiss()
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("This will clear your profile and practice history. You'll go through onboarding again.")
        }
    }
}
