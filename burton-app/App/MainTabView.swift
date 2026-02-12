import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            Tab("Chat", systemImage: "bubble.left.and.text.bubble.right.fill") {
                NavigationStack {
                    ChatView()
                }
            }

            Tab("History", systemImage: "clock.fill") {
                NavigationStack {
                    HistoryView()
                }
            }

            Tab("Settings", systemImage: "gearshape.fill") {
                NavigationStack {
                    SettingsView()
                }
            }
        }
        .tint(.golfGreen)
    }
}
