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

            VStack(spacing: 14) {
                Spacer().frame(minHeight: 10, maxHeight: 40)

                // Header
                headerSection

                // Feature list
                featureList

                // Plan cards
                planCards

                // CTA button + reassurance
                purchaseButton

                // Skip / Continue free
                skipButton

                // Trial disclaimer + footer
                trialDisclaimer

                footerLinks

                Spacer().frame(height: 8)
            }
            .padding(.top, 20)

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
        VStack(spacing: 10) {
            CaddieLogoView(size: 80, style: .glyph)

            Text("Know Exactly\nWhat to Fix")
                .font(.title2.bold())
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
        }
    }

    // MARK: - Feature List

    private var featureList: some View {
        VStack(alignment: .leading, spacing: 10) {
            featureRow(
                text: "Instant swing feedback on every video",
                subtitle: "Free: 3 lifetime analyses"
            )
            featureRow(
                text: "Unlimited AI coaching chat",
                subtitle: "Free: 10 lifetime messages"
            )
            featureRow(
                text: "Caddie AI remembers your swing over time",
                subtitle: "Free: Not available"
            )
            featureRow(
                text: "Track progress and see what\u{2019}s improving",
                subtitle: "Free: Not available"
            )
        }
        .padding(.horizontal, 36)
    }

    private func featureRow(text: String, subtitle: String? = nil) -> some View {
        VStack(alignment: .leading, spacing: 3) {
            HStack(alignment: .top, spacing: 12) {
                Image(systemName: "checkmark.circle.fill")
                    .font(.subheadline)
                    .foregroundStyle(.green)
                    .padding(.top, 1)

                Text(text)
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.white.opacity(0.95))
                    .fixedSize(horizontal: false, vertical: true)
            }

            if let subtitle {
                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.45))
                    .padding(.leading, 30)
            }
        }
    }

    // MARK: - Plan Card

    private var planCards: some View {
        VStack(spacing: 12) {
            if let yearly = subscriptionManager.yearlyPackage {
                PlanCard(
                    title: "Yearly",
                    priceLabel: "\(yearly.localizedPriceString)/year after trial",
                    perMonthLabel: yearlyPerMonthLabel(for: yearly),
                    badge: "SAVE 44%",
                    isSelected: selectedPackage?.identifier == yearly.identifier
                ) {
                    selectedPackage = yearly
                }
            }

            if let monthly = subscriptionManager.monthlyPackage {
                PlanCard(
                    title: "Monthly",
                    priceLabel: "\(monthly.localizedPriceString)/month after trial",
                    perMonthLabel: nil,
                    badge: nil,
                    isSelected: selectedPackage?.identifier == monthly.identifier
                ) {
                    selectedPackage = monthly
                }
            }
        }
        .padding(.horizontal, 24)
        .onAppear {
            // Default to yearly if available
            selectedPackage = subscriptionManager.yearlyPackage ?? subscriptionManager.monthlyPackage
        }
    }

    private func yearlyPerMonthLabel(for package: Package) -> String {
        let price = package.storeProduct.price as NSDecimalNumber
        let monthly = price.doubleValue / 12.0
        return String(format: "$%.2f/month", monthly)
    }

    // MARK: - Purchase Button

    private var purchaseButton: some View {
        VStack(spacing: 8) {
            if subscriptionManager.monthlyPackage == nil && subscriptionManager.purchaseError != nil {
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
                            Text("Start My Free Trial")
                                .font(.headline)
                                .foregroundStyle(.appAccent)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(.white, in: RoundedRectangle(cornerRadius: 14))
                }
                .buttonStyle(.plain)
                .disabled(subscriptionManager.isLoading || selectedPackage == nil)
                .padding(.horizontal, 32)
            }

            Text(billingClarityText)
                .font(.caption2)
                .foregroundStyle(.white.opacity(0.65))
        }
    }

    // MARK: - Skip Button

    @ViewBuilder
    private var skipButton: some View {
        if let onSkip {
            Button {
                Haptics.light()
                onSkip()
            } label: {
                Text("Continue with free version")
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.white.opacity(0.85))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.white.opacity(0.15), in: RoundedRectangle(cornerRadius: 14))
            }
            .buttonStyle(.plain)
            .padding(.horizontal, 32)
        } else if showCloseButton {
            Button {
                Haptics.light()
                dismiss()
            } label: {
                Text("Continue with free version")
                    .font(.subheadline.weight(.medium))
                    .foregroundStyle(.white.opacity(0.85))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.white.opacity(0.15), in: RoundedRectangle(cornerRadius: 14))
            }
            .buttonStyle(.plain)
            .padding(.horizontal, 32)
        }
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
                .font(.caption2)
                .foregroundStyle(.white.opacity(0.55))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 32)
        }
    }

    private var billingClarityText: String {
        guard let package = selectedPackage else {
            return "Select a plan above"
        }
        let isYearly = package.identifier == subscriptionManager.yearlyPackage?.identifier
        if isYearly {
            return "3-day free trial, then \(package.localizedPriceString)/year. Auto-renews until canceled."
        }
        return "3-day free trial, then \(package.localizedPriceString)/month. Auto-renews until canceled."
    }

    private var disclaimerText: String {
        guard let package = selectedPackage else {
            return "Cancel anytime. Payment will be charged to your Apple ID account at confirmation of purchase. Subscription automatically renews unless cancelled at least 24 hours before the end of the current period. Manage in Settings \u{203A} Apple ID \u{203A} Subscriptions."
        }
        let isYearly = package.identifier == subscriptionManager.yearlyPackage?.identifier
        let periodText = isYearly ? "\(package.localizedPriceString)/year" : "\(package.localizedPriceString)/month"
        return "3-day free trial, then \(periodText). Cancel anytime. Payment will be charged to your Apple ID account at confirmation of purchase. Subscription automatically renews unless cancelled at least 24 hours before the end of the current period. Manage in Settings \u{203A} Apple ID \u{203A} Subscriptions."
    }

    // MARK: - Footer Links

    private var footerLinks: some View {
        VStack(spacing: 12) {
            Button {
                Haptics.light()
                Task { await subscriptionManager.restorePurchases() }
            } label: {
                Text("Restore Purchases")
                    .font(.caption)
                    .foregroundStyle(.white.opacity(0.6))
            }

            HStack(spacing: 16) {
                Link("Terms of Use",
                     destination: URL(string: "https://www.apple.com/legal/internet-services/itunes/dev/stdeula/")!)
                    .font(.caption2)
                    .foregroundStyle(.white.opacity(0.5))

                Text("\u{2022}")
                    .font(.caption2)
                    .foregroundStyle(.white.opacity(0.3))

                Link("Privacy Policy",
                     destination: URL(string: "https://super-halva-39ad89.netlify.app/privacy.html")!)
                    .font(.caption2)
                    .foregroundStyle(.white.opacity(0.5))
            }
        }
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
                            .font(.caption2)
                            .opacity(0.6)
                    }
                }

                Spacer()

                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                    .font(.title2)
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(
                isSelected ? Color.white.opacity(0.2) : Color.white.opacity(0.08),
                in: RoundedRectangle(cornerRadius: 14)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .strokeBorder(
                        isSelected ? Color.white.opacity(0.9) : Color.clear,
                        lineWidth: 2.5
                    )
            )
            .foregroundStyle(.white)
        }
    }
}
