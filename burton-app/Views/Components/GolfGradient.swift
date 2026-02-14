import SwiftUI

struct AppGradient: View {
    var body: some View {
        LinearGradient(
            colors: [.appAccent, .appAccentDark],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
}
