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

struct PrioritizedIssue: Codable, Identifiable {
    let id: UUID
    let name: String
    let priority: IssuePriority

    init(id: UUID = UUID(), name: String, priority: IssuePriority) {
        self.id = id
        self.name = name
        self.priority = priority
    }

    enum IssuePriority: String, Codable, CaseIterable {
        case high = "high"
        case medium = "medium"
        case low = "low"

        var sortOrder: Int {
            switch self {
            case .high: return 0
            case .medium: return 1
            case .low: return 2
            }
        }
    }
}

struct RecommendedDrill: Codable, Identifiable {
    let id: UUID
    let drillID: String
    let reason: String
    let priority: PrioritizedIssue.IssuePriority

    init(id: UUID = UUID(), drillID: String, reason: String, priority: PrioritizedIssue.IssuePriority) {
        self.id = id
        self.drillID = drillID
        self.reason = reason
        self.priority = priority
    }
}

struct SwingProfile: Codable {
    var summary: String
    var identifiedIssues: [String]
    var prioritizedIssues: [PrioritizedIssue]
    var recommendedDrills: [RecommendedDrill]
    var strengths: [String]
    var currentFocusAreas: [String]
    var progressNotes: [ProgressNote]

    static let empty = SwingProfile(
        summary: "",
        identifiedIssues: [],
        prioritizedIssues: [],
        recommendedDrills: [],
        strengths: [],
        currentFocusAreas: [],
        progressNotes: []
    )

    var isEmpty: Bool {
        summary.isEmpty && identifiedIssues.isEmpty && prioritizedIssues.isEmpty && strengths.isEmpty && currentFocusAreas.isEmpty
    }
}
