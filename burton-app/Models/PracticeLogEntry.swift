import Foundation

struct PracticeLogEntry: Identifiable, Codable {
    let id: UUID
    let date: Date
    let drillID: String?
    let drillName: String
    let durationMinutes: Int
    let rating: Int // 1-5
    let notes: String

    init(id: UUID = UUID(), date: Date = Date(), drillID: String? = nil, drillName: String, durationMinutes: Int, rating: Int, notes: String) {
        self.id = id
        self.date = date
        self.drillID = drillID
        self.drillName = drillName
        self.durationMinutes = durationMinutes
        self.rating = min(max(rating, 1), 5)
        self.notes = notes
    }
}
