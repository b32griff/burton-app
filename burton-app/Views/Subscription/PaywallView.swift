import SwiftUI
import RevenueCat

struct PaywallView: View {
    @Environment(SubscriptionManager.self) private var subscriptionManager
    @State private var selectedPackage: Package?
    var onSubscribed: (() -> Void)?
    var onSkip: (() -> Void)?
    var showCloseButton: Bool = false
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            AppGradient()

            ScrollView(showsIndicators: false) {
                VStack(spacing: 24) {
                    Spacer().frame(height: 50)

                    // Header
                    headerSection

                    // Feature list
                    featureList

                    // Plan cards
                    planCards

                    // CTA button
                    purchaseButton

                    // Trial disclaimer
                    trialDisclaimer

                    // Footer links
                    footerLinks

                    Spacer().frame(height: 20)
                }
            }

            // Close button (standalone paywall only)
            if showCloseButton {
                VStack {
                    HStack {
                        Spacer()
                        Button { Haptics.light(); dismiss() } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title2)
                                .foregroundStyle(.white.opacity(0.7))
                        }
                        .padding(.trailing, 20)
                        .padding(.top, 16)
                    }
                    Spacer()
                }
            }
        }
    }

    // MARK: - Header

    private var headerSection: some View {
        VStack(spacing: 12) {
            CaddieLogoView(size: 90, style: .glyph)

            Text("Unlock Your\nFull Potential")
                .font(.largeTitle.bold())
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)

            Text("Start your 3-day free trial and get unlimited access to Caddie AI.")
                .font(.body)
                .foregroundStyle(.white.opacity(0.9))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
        }
    }

    // MARK: - Feature List

    private var featureList: some View {
        VStack(alignment: .leading, spacing: 12) {
            featureRow(icon: "video.fill", text: "Unlimited swing video analysis", subtitle: "Free: 5/month")
            featureRow(icon: "figure.golf", text: "All 74 drills, every difficulty", subtitle: "Free: Beginner only")
            featureRow(icon: "brain.head.profile", text: "Persistent swing memory", subtitle: "Free: Not available")
            featureRow(icon: "chart.line.uptrend.xyaxis", text: "Progress tracking & history", subtitle: "Free: Not available")
        }
        .padding(.horizontal, 40)
    }

    private func featureRow(icon: String, text: String, subtitle: String? = nil) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            HStack(spacing: 14) {
                Image(systemName: "checkmark.circle.fill")
                    .font(.body)
                    .foregroundStyle(.green)

                Text(text)
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.95))
            }

            if let subtitle {
                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.5))
                    .padding(.leading, 38)
            }
        }
    }

    // MARK: - Plan Card

    private var planCards: some View {
        VStack(spacing: 12) {
            if let monthly = subscriptionManager.monthlyPackage {
                PlanCard(
                    title: "Monthly",
                    priceLabel: "\(monthly.localizedPriceString)/month",
                    perMonthLabel: nil,
                    badge: nil,
                    isSelected: true
                ) {}
            }
        }
        .padding(.horizontal, 24)
        .onAppear {
            selectedPackage = subscriptionManager.monthlyPackage
        }
    }

    // MARK: - Purchase Button

    private var purchaseButton: some View {
        VStack(spacing: 12) {
            if subscriptionManager.monthlyPackage == nil && subscriptionManager.purchaseError != nil {
                // Offerings failed to load — show retry
                Button {
                    Haptics.medium()
                    Task { await subscriptionManager.fetchOfferings() }
                } label: {
                    Text("Retry Loading")
                        .font(.headline)
                        .foregroundStyle(.appAccent)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.white, in: RoundedRectangle(cornerRadius: 14))
                }
                .buttonStyle(.plain)
                .padding(.horizontal, 32)
            } else {
                Button {
                    Haptics.medium()
                    guard let package = selectedPackage else { return }
                    Task {
                        await subscriptionManager.purchase(package)
                        if subscriptionManager.isSubscribed {
                            Haptics.success()
                            onSubscribed?()
                            dismiss()
                        }
                    }
                } label: {
                    Group {
                        if subscriptionManager.isLoading {
                            ProgressView()
                                .tint(.appAccent)
                        } else {
                            Text(purchaseButtonTitle)
                                .font(.headline)
                                .foregroundStyle(.appAccent)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.white, in: RoundedRectangle(cornerRadius: 14))
                }
                .buttonStyle(.plain)
                .disabled(subscriptionManager.isLoading || selectedPackage == nil)
                .padding(.horizontal, 32)
            }
        }
    }

    private var purchaseButtonTitle: String {
        "Start Free Trial"
    }

    // MARK: - Trial Disclaimer

    private var trialDisclaimer: some View {
        VStack(spacing: 4) {
            if let error = subscriptionManager.purchaseError {
                Text(error)
                    .font(.caption)
                    .foregroundStyle(.red)
                    .padding(.bottom, 4)
            }

            Text(disclaimerText)
                .font(.caption)
                .foregroundStyle(.white.opacity(0.7))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
        }
    }

    private var disclaimerText: String {
        guard let package = selectedPackage else {
            return "3-day free trial. Cancel anytime."
        }
        return "3-day free trial, then \(package.localizedPriceString) per month. Cancel anytime."
    }

    // MARK: - Footer Links

    private var footerLinks: some View {
        VStack(spacing: 12) {
            if let onSkip {
                Button { Haptics.light(); onSkip() } label: {
                    Text("Continue without trial")
                        .font(.subheadline)
                        .foregroundStyle(.white.opacity(0.6))
                        .underline()
                }
            }

            Button {
                Haptics.light()
                Task { await subscriptionManager.restorePurchases() }
            } label: {
                Text("Restore Purchases")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.8))
            }

            HStack(spacing: 16) {
                Link("Terms of Use",
                     destination: URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/")!)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.6))

                Text("|")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.4))

                Link("Privacy Policy",
                     destination: URL(string: "https://b32griff.github.io/burton-app/privacy.html")!)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.6))
            }
        }
        .padding(.top, 8)
    }

}

// MARK: - Plan Card

struct PlanCard: View {
    let title: String
    let priceLabel: String
    let perMonthLabel: String?
    let badge: String?
    let isSelected: Bool
    let onTap: () -> Void

    var body: some View {
        Button { Haptics.selection(); onTap() } label: {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 8) {
                        Text(title)
                            .font(.headline)

                        if let badge {
                            Text(badge)
                                .font(.caption2.bold())
                                .padding(.horizontal, 8)
                                .padding(.vertical, 3)
                                .background(.yellow, in: Capsule())
                                .foregroundStyle(.black)
                        }
                    }

                    Text(priceLabel)
                        .font(.subheadline)
                        .opacity(0.9)

                    if let perMonthLabel {
                        Text(perMonthLabel)
                            .font(.caption)
                            .opacity(0.7)
                    }
                }

                Spacer()

                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                isSelected ? Color.white.opacity(0.25) : Color.white.opacity(0.1),
                in: RoundedRectangle(cornerRadius: 12)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .strokeBorder(
                        isSelected ? Color.white : Color.clear,
                        lineWidth: 2
                    )
            )
            .foregroundStyle(.white)
        }
    }
}
