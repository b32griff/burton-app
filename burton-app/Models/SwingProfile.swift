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

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(UUID.self, forKey: .id) ?? UUID()
        date = try container.decodeIfPresent(Date.self, forKey: .date) ?? Date()
        note = try container.decodeIfPresent(String.self, forKey: .note) ?? ""
    }
}

struct SessionRecord: Codable, Identifiable {
    let id: UUID
    let date: Date
    let rootCause: String
    let assignedDrill: String
    let overallScore: Int // 1-10

    init(id: UUID = UUID(), date: Date = Date(), rootCause: String, assignedDrill: String, overallScore: Int) {
        self.id = id
        self.date = date
        self.rootCause = rootCause
        self.assignedDrill = assignedDrill
        self.overallScore = overallScore
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(UUID.self, forKey: .id) ?? UUID()
        date = try container.decodeIfPresent(Date.self, forKey: .date) ?? Date()
        rootCause = try container.decodeIfPresent(String.self, forKey: .rootCause) ?? ""
        assignedDrill = try container.decodeIfPresent(String.self, forKey: .assignedDrill) ?? ""
        overallScore = try container.decodeIfPresent(Int.self, forKey: .overallScore) ?? 5
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

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(UUID.self, forKey: .id) ?? UUID()
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        priority = try container.decodeIfPresent(IssuePriority.self, forKey: .priority) ?? .medium
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

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(UUID.self, forKey: .id) ?? UUID()
        drillID = try container.decodeIfPresent(String.self, forKey: .drillID) ?? ""
        reason = try container.decodeIfPresent(String.self, forKey: .reason) ?? ""
        priority = try container.decodeIfPresent(PrioritizedIssue.IssuePriority.self, forKey: .priority) ?? .medium
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
    var sessionHistory: [SessionRecord]

    static let empty = SwingProfile(
        summary: "",
        identifiedIssues: [],
        prioritizedIssues: [],
        recommendedDrills: [],
        strengths: [],
        currentFocusAreas: [],
        progressNotes: [],
        sessionHistory: []
    )

    var isEmpty: Bool {
        summary.isEmpty && identifiedIssues.isEmpty && prioritizedIssues.isEmpty && strengths.isEmpty && currentFocusAreas.isEmpty
    }

    init(summary: String = "", identifiedIssues: [String] = [], prioritizedIssues: [PrioritizedIssue] = [], recommendedDrills: [RecommendedDrill] = [], strengths: [String] = [], currentFocusAreas: [String] = [], progressNotes: [ProgressNote] = [], sessionHistory: [SessionRecord] = []) {
        self.summary = summary
        self.identifiedIssues = identifiedIssues
        self.prioritizedIssues = prioritizedIssues
        self.recommendedDrills = recommendedDrills
        self.strengths = strengths
        self.currentFocusAreas = currentFocusAreas
        self.progressNotes = progressNotes
        self.sessionHistory = sessionHistory
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        summary = try container.decodeIfPresent(String.self, forKey: .summary) ?? ""
        identifiedIssues = try container.decodeIfPresent([String].self, forKey: .identifiedIssues) ?? []
        prioritizedIssues = try container.decodeIfPresent([PrioritizedIssue].self, forKey: .prioritizedIssues) ?? []
        recommendedDrills = try container.decodeIfPresent([RecommendedDrill].self, forKey: .recommendedDrills) ?? []
        strengths = try container.decodeIfPresent([String].self, forKey: .strengths) ?? []
        currentFocusAreas = try container.decodeIfPresent([String].self, forKey: .currentFocusAreas) ?? []
        progressNotes = try container.decodeIfPresent([ProgressNote].self, forKey: .progressNotes) ?? []
        sessionHistory = try container.decodeIfPresent([SessionRecord].self, forKey: .sessionHistory) ?? []
    }
}
