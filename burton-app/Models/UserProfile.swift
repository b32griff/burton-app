import Foundation

enum SkillLevel: String, Codable, CaseIterable, Identifiable {
    case beginner = "Beginner"
    case intermediate = "Intermediate"
    case advanced = "Advanced"
    case scratch = "Scratch"

    var id: String { rawValue }

    var description: String {
        switch self {
        case .beginner: "New to golf or high handicap (25+)"
        case .intermediate: "Comfortable on the course (15-24)"
        case .advanced: "Competitive player (5-14)"
        case .scratch: "Scratch or near-scratch (0-4)"
        }
    }

    var icon: String {
        switch self {
        case .beginner: "figure.golf"
        case .intermediate: "star.leadinghalf.filled"
        case .advanced: "star.fill"
        case .scratch: "trophy.fill"
        }
    }

    static func from(handicap: Double) -> SkillLevel {
        switch handicap {
        case ..<5: return .scratch
        case 5..<15: return .advanced
        case 15..<25: return .intermediate
        default: return .beginner
        }
    }
}

enum ImprovementGoal: String, Codable, CaseIterable, Identifiable {
    case distance = "Hit It Farther"
    case accuracy = "Improve Accuracy"
    case shortGame = "Short Game"
    case putting = "Better Putting"
    case consistency = "More Consistency"
    case mentalGame = "Mental Game"
    case courseManagement = "Course Management"
    case lowerScores = "Lower Scores"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .distance: "arrow.up.right"
        case .accuracy: "target"
        case .shortGame: "flag.fill"
        case .putting: "circle.dotted"
        case .consistency: "chart.line.uptrend.xyaxis"
        case .mentalGame: "brain.head.profile"
        case .courseManagement: "map.fill"
        case .lowerScores: "number"
        }
    }
}

struct UserProfile: Codable {
    var name: String
    var handicap: Double?
    var skillLevel: SkillLevel
    var goals: [ImprovementGoal]
    var hasCompletedOnboarding: Bool

    static let empty = UserProfile(
        name: "",
        handicap: nil,
        skillLevel: .beginner,
        goals: [],
        hasCompletedOnboarding: false
    )

    init(name: String, handicap: Double? = nil, skillLevel: SkillLevel = .beginner, goals: [ImprovementGoal] = [], hasCompletedOnboarding: Bool = false) {
        self.name = name
        self.handicap = handicap
        self.skillLevel = skillLevel
        self.goals = goals
        self.hasCompletedOnboarding = hasCompletedOnboarding
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        handicap = try container.decodeIfPresent(Double.self, forKey: .handicap)
        skillLevel = try container.decodeIfPresent(SkillLevel.self, forKey: .skillLevel) ?? .beginner
        goals = try container.decodeIfPresent([ImprovementGoal].self, forKey: .goals) ?? []
        hasCompletedOnboarding = try container.decodeIfPresent(Bool.self, forKey: .hasCompletedOnboarding) ?? false
    }
}
