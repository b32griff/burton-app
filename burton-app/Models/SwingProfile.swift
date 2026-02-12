import Foundation

struct ProgressNote: Codable, Identifiable {
    let id: UUID
    let date: Date
    let note: String

    init(id: UUID = UUID(), date: Date = Date(), note: String) {
        self.id = id
        self.date = date
        self.note = note
    }
}

struct SwingProfile: Codable {
    var summary: String
    var identifiedIssues: [String]
    var strengths: [String]
    var currentFocusAreas: [String]
    var progressNotes: [ProgressNote]

    static let empty = SwingProfile(
        summary: "",
        identifiedIssues: [],
        strengths: [],
        currentFocusAreas: [],
        progressNotes: []
    )

    var isEmpty: Bool {
        summary.isEmpty && identifiedIssues.isEmpty && strengths.isEmpty && currentFocusAreas.isEmpty
    }
}
