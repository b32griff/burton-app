import SwiftUI

struct SettingsView: View {
    @Environment(AppState.self) private var appState
    @Environment(SwingMemoryManager.self) private var memoryManager
    @State private var viewModel = SettingsViewModel()

    // Local edit state
    @State private var name = ""
    @State private var handicapText = ""
    @State private var skillLevel: SkillLevel = .beginner
    @State private var goals: Set<ImprovementGoal> = []

    var body: some View {
        Form {
            // MARK: - API Key
            Section("API Key") {
                if viewModel.hasAPIKey {
                    HStack {
                        Label("Connected", systemImage: "checkmark.circle.fill")
                            .foregroundStyle(.green)
                        Spacer()
                        Button("Change") {
                            viewModel.showAPIKeySetup = true
                        }
                    }

                    Button("Remove API Key", role: .destructive) {
                        viewModel.deleteAPIKey()
                    }
                } else {
                    Button {
                        viewModel.showAPIKeySetup = true
                    } label: {
                        Label("Add API Key", systemImage: "key.fill")
                    }
                }
            }

            // MARK: - Profile
            Section("Profile") {
                TextField("Name", text: $name)

                HStack {
                    Text("Handicap")
                    Spacer()
                    TextField("Optional", text: $handicapText)
                        .keyboardType(.decimalPad)
                        .multilineTextAlignment(.trailing)
                        .frame(width: 80)
                }

                Picker("Skill Level", selection: $skillLevel) {
                    ForEach(SkillLevel.allCases) { level in
                        Text(level.rawValue).tag(level)
                    }
                }
            }

            // MARK: - Goals
            Section("Goals") {
                ForEach(ImprovementGoal.allCases) { goal in
                    Button {
                        if goals.contains(goal) {
                            goals.remove(goal)
                        } else {
                            goals.insert(goal)
                        }
                    } label: {
                        HStack {
                            Image(systemName: goal.icon)
                                .frame(width: 24)
                            Text(goal.rawValue)
                                .foregroundStyle(.primary)
                            Spacer()
                            if goals.contains(goal) {
                                Image(systemName: "checkmark")
                                    .foregroundStyle(.golfGreen)
                            }
                        }
                    }
                }
            }

            // MARK: - Save Profile
            Section {
                Button("Save Profile") {
                    let handicap = Double(handicapText)
                    appState.updateProfile(
                        name: name,
                        handicap: handicap,
                        skillLevel: skillLevel,
                        goals: Array(goals)
                    )
                }
            }

            // MARK: - Swing Memory
            Section("Swing Memory") {
                if memoryManager.swingProfile.isEmpty {
                    Text("No swing data yet. Chat with your coach to build your profile.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                } else {
                    if !memoryManager.swingProfile.summary.isEmpty {
                        Text(memoryManager.swingProfile.summary)
                            .font(.subheadline)
                    }

                    Text("\(memoryManager.swingProfile.identifiedIssues.count) issues, \(memoryManager.swingProfile.strengths.count) strengths, \(memoryManager.swingProfile.progressNotes.count) progress notes")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Button("Clear Swing Memory", role: .destructive) {
                    viewModel.showClearMemoryConfirmation = true
                }
            }

            // MARK: - Reset
            Section {
                Button("Reset Everything", role: .destructive) {
                    viewModel.showResetConfirmation = true
                }
            }
        }
        .navigationTitle("Settings")
        .onAppear(perform: loadProfile)
        .sheet(isPresented: $viewModel.showAPIKeySetup) {
            APIKeySetupView()
                .onDisappear {
                    viewModel.refreshAPIKeyStatus()
                }
        }
        .alert("Clear Swing Memory?", isPresented: $viewModel.showClearMemoryConfirmation) {
            Button("Clear", role: .destructive) {
                memoryManager.clearProfile()
                appState.updateSwingProfile(.empty)
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("This will erase all accumulated swing knowledge. Your conversations will be kept.")
        }
        .alert("Reset Everything?", isPresented: $viewModel.showResetConfirmation) {
            Button("Reset", role: .destructive) {
                memoryManager.clearProfile()
                appState.resetOnboarding()
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("This will delete all data including conversations, swing profile, and API key. You'll need to complete onboarding again.")
        }
    }

    private func loadProfile() {
        name = appState.userProfile.name
        handicapText = appState.userProfile.handicap.map { String($0) } ?? ""
        skillLevel = appState.userProfile.skillLevel
        goals = Set(appState.userProfile.goals)
        viewModel.refreshAPIKeyStatus()
    }
}
