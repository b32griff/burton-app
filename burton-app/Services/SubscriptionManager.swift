import Foundation
import RevenueCat

@Observable
class SubscriptionManager {
    // MARK: - Subscription State
    var isSubscribed = false
    var isInTrialPeriod = false
    var hasCheckedStatus = false

    // MARK: - Product State (RevenueCat Packages)
    var offerings: Offerings?
    var monthlyPackage: Package?

    // MARK: - Usage Tracking
    private(set) var videoAnalysesThisMonth: Int = 0
    let videoAnalysisLimit: Int = 5

    // MARK: - UI State
    var isLoading = false
    var purchaseError: String?

    // MARK: - Private
    private var customerInfoTask: Task<Void, Never>?

    init() {
        // Load cached subscription state immediately (prevents flash of free UI)
        isSubscribed = UserDefaults.standard.bool(forKey: "is_subscribed")
        isInTrialPeriod = UserDefaults.standard.bool(forKey: "is_in_trial")
        if isSubscribed { hasCheckedStatus = true }

        loadUsageData()
        startListeningForCustomerInfo()
        Task {
            await fetchOfferings()
            await updateSubscriptionStatus()
        }
    }

    deinit {
        customerInfoTask?.cancel()
    }

    // MARK: - Feature Gating

    var canAnalyzeVideo: Bool {
        isSubscribed || videoAnalysesThisMonth < videoAnalysisLimit
    }

    var remainingVideoAnalyses: Int {
        isSubscribed ? .max : max(0, videoAnalysisLimit - videoAnalysesThisMonth)
    }

    var canAccessAllDrills: Bool {
        isSubscribed
    }

    var canAccessSwingMemory: Bool {
        isSubscribed
    }

    var tierDisplayName: String {
        isSubscribed ? "Pro" : "Free"
    }

    // MARK: - Usage Tracking

    func incrementVideoAnalysis() {
        resetMonthIfNeeded()
        videoAnalysesThisMonth += 1
        UserDefaults.standard.set(videoAnalysesThisMonth, forKey: "video_analysis_count")
    }

    private func resetMonthIfNeeded() {
        let currentMonth = Calendar.current.component(.month, from: Date())
        let currentYear = Calendar.current.component(.year, from: Date())
        let storedMonth = UserDefaults.standard.integer(forKey: "video_analysis_month")
        let storedYear = UserDefaults.standard.integer(forKey: "video_analysis_year")

        if currentMonth != storedMonth || currentYear != storedYear {
            videoAnalysesThisMonth = 0
            UserDefaults.standard.set(0, forKey: "video_analysis_count")
            UserDefaults.standard.set(currentMonth, forKey: "video_analysis_month")
            UserDefaults.standard.set(currentYear, forKey: "video_analysis_year")
        }
    }

    private func loadUsageData() {
        resetMonthIfNeeded()
        videoAnalysesThisMonth = UserDefaults.standard.integer(forKey: "video_analysis_count")
    }

    // MARK: - Fetch Offerings

    @MainActor
    func fetchOfferings() async {
        do {
            let rcOfferings = try await Purchases.shared.offerings()
            offerings = rcOfferings

            if let current = rcOfferings.current {
                monthlyPackage = current.monthly
            }
        } catch {
            purchaseError = "Failed to load subscription options."
        }
    }

    // MARK: - Purchase

    @MainActor
    func purchase(_ package: Package) async {
        isLoading = true
        purchaseError = nil

        do {
            let result = try await Purchases.shared.purchase(package: package)
            if !result.userCancelled {
                updateFromCustomerInfo(result.customerInfo)
            }
        } catch {
            purchaseError = "Purchase failed. Please try again."
        }

        isLoading = false
    }

    // MARK: - Restore Purchases

    @MainActor
    func restorePurchases() async {
        isLoading = true
        purchaseError = nil

        do {
            let customerInfo = try await Purchases.shared.restorePurchases()
            updateFromCustomerInfo(customerInfo)

            if !isSubscribed {
                purchaseError = "No active subscription found."
            }
        } catch {
            purchaseError = "Restore failed. Please try again."
        }

        isLoading = false
    }

    // MARK: - Subscription Status

    @MainActor
    func updateSubscriptionStatus() async {
        do {
            let customerInfo = try await Purchases.shared.customerInfo()
            updateFromCustomerInfo(customerInfo)
        } catch {
            // Keep cached state on error
            hasCheckedStatus = true
        }
    }

    // MARK: - Customer Info Listener

    private func startListeningForCustomerInfo() {
        customerInfoTask = Task { [weak self] in
            for await customerInfo in Purchases.shared.customerInfoStream {
                await self?.updateFromCustomerInfo(customerInfo)
            }
        }
    }

    // MARK: - Process Customer Info

    @MainActor
    private func updateFromCustomerInfo(_ customerInfo: CustomerInfo) {
        let entitlement = customerInfo.entitlements["Caddie AI Pro"]
        isSubscribed = entitlement?.isActive ?? false

        if let entitlement, entitlement.isActive {
            isInTrialPeriod = entitlement.periodType == .trial
        } else {
            isInTrialPeriod = false
        }

        hasCheckedStatus = true
        persistSubscriptionState()
    }

    // MARK: - Dev/Simulator Bypass

    /// Activates subscription locally when RevenueCat products aren't available (simulator/testing)
    @MainActor
    func activateDevBypass() {
        #if DEBUG
        isSubscribed = true
        isInTrialPeriod = true
        hasCheckedStatus = true
        persistSubscriptionState()
        #endif
    }

    private func persistSubscriptionState() {
        UserDefaults.standard.set(isSubscribed, forKey: "is_subscribed")
        UserDefaults.standard.set(isInTrialPeriod, forKey: "is_in_trial")
    }
}
