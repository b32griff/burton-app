import SwiftUI
import StoreKit

struct PaywallView: View {
    @Environment(SubscriptionManager.self) private var subscriptionManager
    @State private var selectedProduct: Product?
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

            Text("Start your 7-day free trial and get unlimited access to Caddie AI.")
                .font(.body)
                .foregroundStyle(.white.opacity(0.9))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
        }
    }

    // MARK: - Feature List

    private var featureList: some View {
        VStack(alignment: .leading, spacing: 12) {
            featureRow(icon: "video.fill", text: "Unlimited swing video analysis", subtitle: "Free: 2/month")
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

    // MARK: - Plan Cards

    private var planCards: some View {
        VStack(spacing: 12) {
            if let yearly = subscriptionManager.yearlyProduct {
                PlanCard(
                    title: "Yearly",
                    priceLabel: "\(yearly.displayPrice)/year",
                    perMonthLabel: monthlyEquivalent(from: yearly),
                    badge: "SAVE 33%",
                    isSelected: selectedProduct?.id == yearly.id
                ) {
                    selectedProduct = yearly
                }
            }

            if let monthly = subscriptionManager.monthlyProduct {
                PlanCard(
                    title: "Monthly",
                    priceLabel: "\(monthly.displayPrice)/month",
                    perMonthLabel: nil,
                    badge: nil,
                    isSelected: selectedProduct?.id == monthly.id
                ) {
                    selectedProduct = monthly
                }
            }
        }
        .padding(.horizontal, 24)
        .onAppear {
            if selectedProduct == nil {
                selectedProduct = subscriptionManager.yearlyProduct ?? subscriptionManager.monthlyProduct
            }
        }
    }

    // MARK: - Purchase Button

    private var purchaseButton: some View {
        Button {
            Haptics.medium()
            if let product = selectedProduct {
                Task {
                    await subscriptionManager.purchase(product)
                    if subscriptionManager.isSubscribed {
                        Haptics.success()
                        onSubscribed?()
                    }
                }
            } else {
                // No products loaded (simulator/testing) — skip through
                onSubscribed?()
                onSkip?()
            }
        } label: {
            Group {
                if subscriptionManager.isLoading {
                    ProgressView()
                        .tint(.appAccent)
                } else {
                    Text("Start Free Trial")
                        .font(.headline)
                        .foregroundStyle(.appAccent)
                }
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.white, in: RoundedRectangle(cornerRadius: 14))
        }
        .buttonStyle(.plain)
        .disabled(subscriptionManager.isLoading)
        .padding(.horizontal, 32)
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
        guard let product = selectedProduct else {
            return "7-day free trial. Cancel anytime."
        }
        let period = product.id == "yearly_sub" ? "year" : "month"
        return "7-day free trial, then \(product.displayPrice) per \(period). Cancel anytime."
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
                     destination: URL(string: "https://burtongriffin.com/privacy")!)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.6))
            }
        }
        .padding(.top, 8)
    }

    // MARK: - Helpers

    private func monthlyEquivalent(from yearlyProduct: Product) -> String {
        let monthly = yearlyProduct.price / 12
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = yearlyProduct.priceFormatStyle.locale
        return (formatter.string(from: monthly as NSDecimalNumber) ?? "") + "/mo"
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
