import SwiftUI

struct RatingStars: View {
    @Binding var rating: Int
    var maxRating: Int = 5
    var interactive: Bool = true

    var body: some View {
        HStack(spacing: 4) {
            ForEach(1...maxRating, id: \.self) { star in
                Image(systemName: star <= rating ? "star.fill" : "star")
                    .foregroundStyle(star <= rating ? .yellow : .gray.opacity(0.4))
                    .font(.title3)
                    .onTapGesture {
                        if interactive {
                            rating = star
                        }
                    }
            }
        }
    }
}

struct StaticRatingStars: View {
    let rating: Int
    var maxRating: Int = 5

    var body: some View {
        HStack(spacing: 2) {
            ForEach(1...maxRating, id: \.self) { star in
                Image(systemName: star <= rating ? "star.fill" : "star")
                    .foregroundStyle(star <= rating ? .yellow : .gray.opacity(0.4))
                    .font(.caption)
            }
        }
    }
}
