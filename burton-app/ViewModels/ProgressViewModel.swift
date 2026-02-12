import Foundation

@Observable
class ProgressViewModel {
    func totalSessions(from log: [PracticeLogEntry]) -> Int {
        log.count
    }

    func totalMinutes(from log: [PracticeLogEntry]) -> Int {
        log.reduce(0) { $0 + $1.durationMinutes }
    }

    func averageRating(from log: [PracticeLogEntry]) -> Double {
        guard !log.isEmpty else { return 0 }
        let total = log.reduce(0) { $0 + $1.rating }
        return Double(total) / Double(log.count)
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

    func last7DaysDots(from log: [PracticeLogEntry]) -> [Bool] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let practiceDays = Set(log.map { calendar.startOfDay(for: $0.date) })

        return (0..<7).reversed().map { daysAgo in
            let date = calendar.date(byAdding: .day, value: -daysAgo, to: today)!
            return practiceDays.contains(date)
        }
    }
}
