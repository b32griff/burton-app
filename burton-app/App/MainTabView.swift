import SwiftUI

enum AppTab: Hashable {
    case home, caddie, drills
}

struct MainTabView: View {
    @State private var selectedTab: AppTab = .home

    var body: some View {
        TabView(selection: $selectedTab) {
            Tab("Home", systemImage: "house.fill", value: .home) {
                NavigationStack {
                    HomeView()
                }
            }

            Tab("Caddie", systemImage: "bubble.left.and.text.bubble.right.fill", value: .caddie) {
                NavigationStack {
                    ChatView()
                }
            }

            Tab("Drills", systemImage: "list.bullet.clipboard", value: .drills) {
                NavigationStack {
                    RecommendedDrillsView()
                }
            }
        }
        .tint(.appAccent)
        .environment(\.selectedTab, $selectedTab)
    }
}

// MARK: - Tab Selection Environment Key

private struct SelectedTabKey: EnvironmentKey {
    static let defaultValue: Binding<AppTab> = .constant(.home)
}

extension EnvironmentValues {
    var selectedTab: Binding<AppTab> {
        get { self[SelectedTabKey.self] }
        set { self[SelectedTabKey.self] = newValue }
    }
}
