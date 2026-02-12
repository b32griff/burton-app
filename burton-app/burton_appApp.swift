import SwiftUI

@main
struct burton_appApp: App {
    @State private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            if appState.hasCompletedOnboarding {
                MainTabView()
                    .environment(appState)
            } else {
                OnboardingContainerView()
                    .environment(appState)
            }
        }
    }
}
