import SwiftUI

struct ProgressTrackerView: View {
    @Environment(AppState.self) private var appState
    @State private var viewModel = ProgressViewModel()
    @State private var showLogSheet = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Stats
                statsSection

                // 7-day streak
                streakDotsSection

                // Practice Log
                practiceLogSection
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Progress")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showLogSheet = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showLogSheet) {
            NavigationStack {
                LogPracticeSheet()
            }
        }
    }

    private var statsSection: some View {
        HStack(spacing: 12) {
            StatBadge(
                title: "Sessions",
                value: "\(viewModel.totalSessions(from: appState.practiceLog))",
                icon: "checkmark.circle"
            )
            StatBadge(
                title: "Minutes",
                value: "\(viewModel.totalMinutes(from: appState.practiceLog))",
                icon: "clock"
            )
            StatBadge(
                title: "Avg Rating",
                value: String(format: "%.1f", viewModel.averageRating(from: appState.practiceLog)),
                icon: "star"
            )
        }
    }

    private var streakDotsSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                SectionHeader(title: "Last 7 Days")
                Spacer()
                let streak = viewModel.currentStreak(from: appState.practiceLog)
                if streak > 0 {
                    Label("\(streak)-day streak", systemImage: "flame.fill")
                        .font(.caption.weight(.medium))
                        .foregroundStyle(.orange)
                }
            }

            let dots = viewModel.last7DaysDots(from: appState.practiceLog)
            let dayLabels = last7DayLabels()

            HStack(spacing: 0) {
                ForEach(0..<7, id: \.self) { index in
                    VStack(spacing: 6) {
                        Circle()
                            .fill(dots[index] ? Color.golfGreen : Color.gray.opacity(0.2))
                            .frame(width: 32, height: 32)
                            .overlay {
                                if dots[index] {
                                    Image(systemName: "checkmark")
                                        .font(.caption2.weight(.bold))
                                        .foregroundStyle(.white)
                                }
                            }
                        Text(dayLabels[index])
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding()
            .background(.background, in: RoundedRectangle(cornerRadius: 12))
        }
    }

    private var practiceLogSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            SectionHeader(title: "Practice Log")

            if appState.practiceLog.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "note.text")
                        .font(.largeTitle)
                        .foregroundStyle(.secondary)
                    Text("No practice sessions yet")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    Button("Log Your First Session") {
                        showLogSheet = true
                    }
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.golfGreen)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 32)
                .background(.background, in: RoundedRectangle(cornerRadius: 12))
            } else {
                ForEach(appState.practiceLog) { entry in
                    PracticeLogRow(entry: entry)
                }
            }
        }
    }

    private func last7DayLabels() -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        return (0..<7).reversed().map { daysAgo in
            let date = calendar.date(byAdding: .day, value: -daysAgo, to: today)!
            return formatter.string(from: date)
        }
    }
}
