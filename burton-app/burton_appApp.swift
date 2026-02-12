import SwiftUI

@main
struct burton_appApp: App {
    @State private var appState = AppState()
    @State private var memoryManager = SwingMemoryManager()
    @State private var apiKeyConfigured = KeychainManager.hasAPIKey

    var body: some Scene {
        WindowGroup {
            Group {
                if !appState.hasCompletedOnboarding {
                    OnboardingContainerView()
                } else if !apiKeyConfigured {
                    APIKeySetupView {
                        apiKeyConfigured = true
                    }
                } else {
                    MainTabView()
                }
            }
            .environment(appState)
            .environment(memoryManager)
        }
    }
}
