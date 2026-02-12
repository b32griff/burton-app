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
