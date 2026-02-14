import SwiftUI

@main
struct burton_appApp: App {
    @State private var appState = AppState()
    @State private var memoryManager = SwingMemoryManager()
    @State private var subscriptionManager = SubscriptionManager()

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
            .environment(subscriptionManager)
        }
    }
}
