import SwiftUI

extension Color {
    static let appAccent = Color(red: 0.20, green: 0.50, blue: 0.72)
    static let appAccentLight = Color(red: 0.55, green: 0.75, blue: 0.90)
    static let appAccentDark = Color(red: 0.10, green: 0.30, blue: 0.50)
    static let warmGray = Color(red: 0.85, green: 0.84, blue: 0.82)
    static let coolGray = Color(red: 0.68, green: 0.70, blue: 0.75)
}

extension ShapeStyle where Self == Color {
    static var appAccent: Color { .appAccent }
    static var appAccentLight: Color { .appAccentLight }
    static var appAccentDark: Color { .appAccentDark }
    static var warmGray: Color { .warmGray }
    static var coolGray: Color { .coolGray }
}
