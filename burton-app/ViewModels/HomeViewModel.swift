import Foundation

@Observable
class HomeViewModel {
    var dailyTip: Tip

    init() {
        let tips = TipData.all
        let dayIndex = Date().dayOfYear % tips.count
        self.dailyTip = tips[dayIndex]
    }

    func recentPractice(from log: [PracticeLogEntry], limit: Int = 3) -> [PracticeLogEntry] {
        Array(log.prefix(limit))
    }

    func totalPracticeSessions(from log: [PracticeLogEntry]) -> Int {
        log.count
    }

    func totalPracticeMinutes(from log: [PracticeLogEntry]) -> Int {
        log.reduce(0) { $0 + $1.durationMinutes }
    }

    func currentStreak(from log: [PracticeLogEntry]) -> Int {
        guard !log.isEmpty else { return 0 }

        let calendar = Calendar.current
        let sortedDates = Set(log.map { calendar.startOfDay(for: $0.date) }).sorted(by: >)

        guard let mostRecent = sortedDates.first else { return 0 }

        let today = calendar.startOfDay(for: Date())
        let yesterday = calendar.date(byAdding: .day, value: -1, to: today)!

        guard mostRecent >= yesterday else { return 0 }

        var streak = 1
        for i in 1..<sortedDates.count {
            let expected = calendar.date(byAdding: .day, value: -i, to: mostRecent)!
            if calendar.isDate(sortedDates[i], inSameDayAs: expected) {
                streak += 1
            } else {
                break
            }
        }
        return streak
    }
}
