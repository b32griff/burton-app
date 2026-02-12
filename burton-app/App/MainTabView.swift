import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            Tab("Home", systemImage: "house.fill") {
                NavigationStack {
                    HomeView()
                }
            }

            Tab("Swing Tips", systemImage: "figure.golf") {
                NavigationStack {
                    SwingAnalysisView()
                }
            }

            Tab("Drills", systemImage: "list.bullet.clipboard") {
                NavigationStack {
                    DrillLibraryView()
                }
            }

            Tab("Progress", systemImage: "chart.bar.fill") {
                NavigationStack {
                    ProgressTrackerView()
                }
            }
        }
        .tint(.golfGreen)
    }
}
