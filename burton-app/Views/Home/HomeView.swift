import SwiftUI

struct HomeView: View {
    @Environment(AppState.self) private var appState
    @State private var viewModel = HomeViewModel()
    @State private var showProfile = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Greeting
                greetingSection

                // Daily Tip
                DailyTipCard(tip: viewModel.dailyTip)

                // Quick Actions
                QuickActionGrid()

                // Stats Summary
                statsSection

                // Recent Activity
                recentActivitySection
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Home")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showProfile = true
                } label: {
                    Image(systemName: "person.circle")
                        .font(.title3)
                }
            }
        }
        .sheet(isPresented: $showProfile) {
            NavigationStack {
                ProfileView()
            }
        }
    }

    private var greetingSection: some View {
        VStack(alignment: .leading, spacing: 4) {
            let name = appState.userProfile.name.isEmpty ? "Golfer" : appState.userProfile.name
            Text("Hello, \(name)!")
                .font(.title.bold())
            Text("Ready to improve your game?")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
    }

    private var statsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeader(title: "Your Stats")

            HStack(spacing: 12) {
                StatBadge(
                    title: "Sessions",
                    value: "\(viewModel.totalPracticeSessions(from: appState.practiceLog))",
                    icon: "checkmark.circle"
                )
                StatBadge(
                    title: "Minutes",
                    value: "\(viewModel.totalPracticeMinutes(from: appState.practiceLog))",
                    icon: "clock"
                )
                StatBadge(
                    title: "Streak",
                    value: "\(viewModel.currentStreak(from: appState.practiceLog))d",
                    icon: "flame"
                )
            }
        }
    }

    private var recentActivitySection: some View {
        let recent = viewModel.recentPractice(from: appState.practiceLog)
        return Group {
            if !recent.isEmpty {
                VStack(alignment: .leading, spacing: 12) {
                    SectionHeader(title: "Recent Practice")

                    ForEach(recent) { entry in
                        PracticeLogRow(entry: entry)
                    }
                }
            }
        }
    }
}
