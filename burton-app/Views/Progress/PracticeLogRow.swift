import SwiftUI

struct PracticeLogRow: View {
    let entry: PracticeLogEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(entry.drillName)
                    .font(.subheadline.weight(.medium))
                Spacer()
                Text(entry.date.relativeFormatted)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            HStack(spacing: 12) {
                Label("\(entry.durationMinutes) min", systemImage: "clock")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                StaticRatingStars(rating: entry.rating)
            }

            if !entry.notes.isEmpty {
                Text(entry.notes)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
        }
        .padding()
        .background(.background, in: RoundedRectangle(cornerRadius: 12))
    }
}
