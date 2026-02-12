import Foundation

extension Date {
    var shortFormatted: String {
        formatted(date: .abbreviated, time: .omitted)
    }

    var dayAndTime: String {
        formatted(date: .abbreviated, time: .shortened)
    }

    var relativeFormatted: String {
        let calendar = Calendar.current
        if calendar.isDateInToday(self) {
            return "Today"
        } else if calendar.isDateInYesterday(self) {
            return "Yesterday"
        } else {
            return shortFormatted
        }
    }

    var dayOfYear: Int {
        Calendar.current.ordinality(of: .day, in: .year, for: self) ?? 0
    }
}
