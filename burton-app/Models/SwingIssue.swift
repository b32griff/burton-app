import Foundation

enum SwingCategory: String, Codable, CaseIterable, Identifiable {
    case fullSwing = "Full Swing"
    case shortGame = "Short Game"
    case putting = "Putting"
    case mental = "Mental"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .fullSwing: "figure.golf"
        case .shortGame: "flag.fill"
        case .putting: "circle.dotted"
        case .mental: "brain.head.profile"
        }
    }
}

struct SwingIssue: Identifiable, Codable {
    let id: String
    let name: String
    let description: String
    let commonCauses: [String]
    let category: SwingCategory
    let linkedTipIDs: [String]
    let linkedDrillIDs: [String]

    var icon: String {
        switch id {
        case "slice": return "arrow.turn.up.right"
        case "hook": return "arrow.turn.up.left"
        case "topping": return "arrow.up"
        case "fat_shots": return "arrow.down"
        case "shanks": return "exclamationmark.triangle"
        case "lack_of_distance": return "arrow.right"
        case "inconsistent_contact": return "questionmark.circle"
        case "poor_chipping": return "flag"
        case "three_putting": return "circle.dotted"
        case "first_tee_nerves": return "brain.head.profile"
        default: return "questionmark"
        }
    }
}
