import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            Tab("Coach", systemImage: "bubble.left.and.text.bubble.right.fill") {
                NavigationStack {
                    ChatView()
                }
            }

            Tab("Drills", systemImage: "list.bullet.clipboard") {
                NavigationStack {
                    RecommendedDrillsView()
                }
            }
        }
        .tint(.golfGreen)
    }
}
