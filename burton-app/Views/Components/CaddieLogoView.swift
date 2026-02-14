import SwiftUI

struct CaddieLogoView: View {
    var size: CGFloat = 80
    var style: Style = .badge

    enum Style {
        case badge   // Blue gradient circle with white icon
        case glyph   // White icon only (for blue backgrounds)
        case accent  // Accent-colored icon (for light backgrounds)
    }

    var body: some View {
        ZStack {
            if style == .badge {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [Color.appAccent, Color.appAccentDark],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .shadow(color: .appAccent.opacity(0.2), radius: size * 0.06, y: size * 0.03)
            }

            golfFlagMark
                .foregroundStyle(style == .accent ? .appAccent : .white)
                .padding(style == .badge ? size * 0.17 : 0)
        }
        .frame(width: size, height: size)
    }

    // MARK: - Golf Flag Pin Mark

    private var golfFlagMark: some View {
        Canvas { context, canvasSize in
            let s = min(canvasSize.width, canvasSize.height)

            func x(_ v: CGFloat) -> CGFloat { s * v / 100 }
            func y(_ v: CGFloat) -> CGFloat { s * v / 100 }
            func pt(_ px: CGFloat, _ py: CGFloat) -> CGPoint {
                CGPoint(x: x(px), y: y(py))
            }

            let fill = GraphicsContext.Shading.foreground

            // --- Flagstick ---
            let stickCX = x(40)
            let stickW = x(5.5)
            var stick = Path()
            stick.addRoundedRect(
                in: CGRect(
                    x: stickCX - stickW / 2,
                    y: y(12),
                    width: stickW,
                    height: y(78) - y(12)
                ),
                cornerSize: CGSize(width: stickW / 2, height: stickW / 2)
            )
            context.fill(stick, with: fill)

            // --- Flag (waving pennant) ---
            let flagLeft = stickCX + stickW / 2
            var flag = Path()
            flag.move(to: CGPoint(x: flagLeft, y: y(12)))
            // Top edge — curves slightly upward (wind effect)
            flag.addQuadCurve(
                to: pt(78, 27),
                control: pt(62, 10)
            )
            // Bottom edge — curves slightly downward, back to stick
            flag.addQuadCurve(
                to: CGPoint(x: flagLeft, y: y(42)),
                control: pt(62, 44)
            )
            flag.closeSubpath()
            context.fill(flag, with: fill)

            // --- Golf ball ---
            let ballR = x(6.5)
            let ballCenter = pt(40, 81)
            context.fill(
                Path(ellipseIn: CGRect(
                    x: ballCenter.x - ballR,
                    y: ballCenter.y - ballR,
                    width: ballR * 2,
                    height: ballR * 2
                )),
                with: fill
            )

            // --- Ground arc ---
            var ground = Path()
            ground.move(to: pt(26, 89))
            ground.addQuadCurve(
                to: pt(54, 89),
                control: pt(40, 85)
            )
            context.stroke(
                ground,
                with: fill,
                style: StrokeStyle(lineWidth: x(3), lineCap: .round)
            )
        }
        .aspectRatio(1, contentMode: .fit)
    }
}

#Preview {
    VStack(spacing: 30) {
        CaddieLogoView(size: 120, style: .badge)

        CaddieLogoView(size: 120, style: .glyph)
            .padding(30)
            .background(Color.appAccent)
            .clipShape(RoundedRectangle(cornerRadius: 20))

        CaddieLogoView(size: 120, style: .accent)
    }
    .padding()
}
