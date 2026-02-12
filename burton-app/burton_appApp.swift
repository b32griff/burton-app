import SwiftUI

@main
struct burton_appApp: App {
    @State private var appState = AppState()
    @State private var memoryManager = SwingMemoryManager()

    var body: some Scene {
        WindowGroup {
            Group {
                if !appState.hasCompletedOnboarding {
                    OnboardingContainerView()
                } else {
                    MainTabView()
                }
            }
            .environment(appState)
            .environment(memoryManager)
        }
    }
}
