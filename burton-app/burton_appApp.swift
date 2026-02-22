import SwiftUI
import RevenueCat

@main
struct burton_appApp: App {
    @State private var appState = AppState()
    @State private var memoryManager = SwingMemoryManager()
    @State private var subscriptionManager = SubscriptionManager()

    init() {
        #if DEBUG
        Purchases.logLevel = .debug
        #endif
        Purchases.configure(withAPIKey: "appl_OtflMovJbWklLnpHkUgogzfGQBi")
    }

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
