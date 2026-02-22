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
        case "early_extension": return "arrow.up.forward"
        case "over_the_top": return "arrow.turn.down.right"
        case "casting": return "arrow.down.right"
        case "reverse_pivot": return "arrow.left.arrow.right"
        case "sway": return "arrow.left.and.right"
        case "loss_of_posture": return "figure.stand"
        case "chicken_wing": return "arrow.up.left"
        case "flat_backswing": return "arrow.down.left"
        case "steep_backswing": return "arrow.up.right"
        case "overswing": return "arrow.up.to.line"
        case "body_stall": return "stop.circle"
        case "poor_weight_transfer": return "scalemass"
        case "poor_grip": return "hand.raised"
        case "poor_setup": return "ruler"
        case "poor_tempo": return "metronome"
        case "flipping": return "arrow.uturn.up"
        default: return "questionmark"
        }
    }
}
