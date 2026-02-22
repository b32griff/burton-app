import Foundation

struct Drill: Identifiable, Codable {
    let id: String
    let name: String
    let instructions: [String]
    let durationMinutes: Int
    let equipment: [String]
    let category: SwingCategory
    let difficulty: Difficulty
}

enum ClubType: String, CaseIterable, Identifiable {
    case driver = "Driver"
    case iron = "Iron"
    case wedge = "Wedge"
    case putter = "Putter"
    var id: Self { self }
}

enum ShotMiss: String, CaseIterable, Identifiable {
    case notSure = "Not Sure"
    case slice = "Slice"
    case hook = "Hook"
    case push = "Push"
    case pull = "Pull"
    case fat = "Fat"
    case thin = "Thin"
    case topped = "Topped"
    case shank = "Shank"

    var id: Self { self }

    var shortLabel: String {
        rawValue
    }

    var analysisContext: String {
        switch self {
        case .notSure:
            return "The golfer is not sure of their typical miss. Diagnose the most likely miss based on the swing mechanics you observe."
        case .slice:
            return "The golfer's miss is a SLICE (curves hard left-to-right for a righty). This usually means an open clubface relative to path. Check: weak grip, over-the-top path, early extension, lack of forearm rotation through impact."
        case .hook:
            return "The golfer's miss is a HOOK (curves hard right-to-left for a righty). This usually means a closed clubface relative to path. Check: strong grip, excessive forearm rotation, path too far inside-out, early wrist flip."
        case .push:
            return "The golfer's miss is a PUSH (ball starts right and stays right for a righty). Face and path are aligned but both aimed right. Check: ball position too far back, alignment, over-rotation of body with arms trailing."
        case .pull:
            return "The golfer's miss is a PULL (ball starts left and stays left for a righty). Face and path are aligned but both aimed left. Check: ball position too far forward, over-the-top with a square face, upper body dominating downswing."
        case .fat:
            return "The golfer's miss is FAT (hitting the ground before the ball). Check: low point too far behind the ball, loss of posture, early extension, weight staying on trail foot, casting/early release of wrist angle."
        case .thin:
            return "The golfer's miss is THIN (catching the ball at the equator or above). Check: standing up through impact, loss of spine angle, trying to help the ball up, not enough shaft lean at impact."
        case .topped:
            return "The golfer's miss is TOPPED (hitting the very top of the ball, ground ball). Check: severe standing up, lifting out of posture, fear of hitting the ground, weight falling backward."
        case .shank:
            return "The golfer's miss is a SHANK (ball comes off the hosel, shoots dead right). Check: weight falling to toes, hands moving away from body in downswing, early extension, standing too close to ball."
        }
    }
}

enum CameraAngle: String, CaseIterable, Identifiable {
    case dtl = "Down the Line"
    case fo = "Face On"

    var id: Self { self }

    var shortLabel: String {
        switch self {
        case .dtl: "DTL"
        case .fo: "Face On"
        }
    }

    var analysisContext: String {
        switch self {
        case .dtl:
            return "Camera is DOWN THE LINE (behind the golfer, looking at target). Analyze: swing plane, club path, posture, takeaway, transition, shaft lean, early extension. Do NOT comment on stance width, ball position, weight shift, or lateral sway — these are invisible from DTL."
        case .fo:
            return "Camera is FACE ON (opposite the golfer). Analyze: weight shift, lateral sway, ball position, stance width, spine tilt, arm extension, hip/shoulder rotation. Do NOT comment on swing plane, club path, or takeaway direction — these are invisible from Face On."
        }
    }
}
