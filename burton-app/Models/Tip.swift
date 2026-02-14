import Foundation

enum Difficulty: String, Codable, CaseIterable, Identifiable {
    case beginner = "Beginner"
    case intermediate = "Intermediate"
    case advanced = "Advanced"

    var id: String { rawValue }

    var color: String {
        switch self {
        case .beginner: "appAccent"
        case .intermediate: "warmGray"
        case .advanced: "appAccentDark"
        }
    }
}

struct Tip: Identifiable, Codable {
    let id: String
    let title: String
    let summary: String
    let body: String
    let difficulty: Difficulty
    let linkedIssueIDs: [String]
}
