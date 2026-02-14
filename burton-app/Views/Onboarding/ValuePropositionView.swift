import SwiftUI

struct ValuePropositionPage {
    let icon: String
    let title: String
    let subtitle: String
    let features: [Feature]

    struct Feature {
        let icon: String
        let text: String
    }
}

struct ValuePropositionView: View {
    let page: ValuePropositionPage
    let onContinue: () -> Void

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            if page.icon == "caddie.logo" {
                CaddieLogoView(size: 110, style: .glyph)
            } else {
                Image(systemName: page.icon)
                    .font(.system(size: 70))
                    .foregroundStyle(.white)
            }

            Text(page.title)
                .font(.largeTitle.bold())
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)

            Text(page.subtitle)
                .font(.body)
                .foregroundStyle(.white.opacity(0.9))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)

            VStack(alignment: .leading, spacing: 16) {
                ForEach(page.features, id: \.text) { feature in
                    HStack(spacing: 14) {
                        Image(systemName: feature.icon)
                            .font(.title3)
                            .foregroundStyle(.white)
                            .frame(width: 28)

                        Text(feature.text)
                            .font(.subheadline)
                            .foregroundStyle(.white.opacity(0.95))
                    }
                }
            }
            .padding(.horizontal, 40)
            .padding(.top, 8)

            Spacer()

            Button(action: onContinue) {
                Text("Continue")
                    .font(.headline)
                    .foregroundStyle(.appAccent)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.white, in: RoundedRectangle(cornerRadius: 14))
            }
            .padding(.horizontal, 32)

            Spacer()
                .frame(height: 40)
        }
    }
}
