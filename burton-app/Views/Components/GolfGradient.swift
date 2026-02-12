import SwiftUI

struct GolfGradient: View {
    var body: some View {
        LinearGradient(
            colors: [.golfGreen, .darkFairway],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
}
