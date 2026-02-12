import SwiftUI

extension Color {
    static let golfGreen = Color(red: 0.18, green: 0.55, blue: 0.34)
    static let fairwayLight = Color(red: 0.56, green: 0.78, blue: 0.49)
    static let sandTrap = Color(red: 0.85, green: 0.75, blue: 0.55)
    static let skyBlue = Color(red: 0.53, green: 0.76, blue: 0.93)
    static let darkFairway = Color(red: 0.12, green: 0.37, blue: 0.22)
}

extension ShapeStyle where Self == Color {
    static var golfGreen: Color { .golfGreen }
    static var fairwayLight: Color { .fairwayLight }
    static var sandTrap: Color { .sandTrap }
    static var skyBlue: Color { .skyBlue }
    static var darkFairway: Color { .darkFairway }
}
