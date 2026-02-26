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
    var yearlyPackage: Package?

    // MARK: - Usage Limits
    // Paid (monthly reset)
    let videoAnalysisLimitPaid: Int = 30
    let chatMessageLimitPaid: Int = 200
    let conversationLimitPaid: Int = 30
    // Free (lifetime)
    let videoAnalysisLimitFree: Int = 3
    let chatMessageLimitFree: Int = 30

    // MARK: - Usage Tracking (paid — monthly)
    private(set) var videoAnalysesThisMonth: Int = 0
    private(set) var chatMessagesThisMonth: Int = 0
    private(set) var conversationsThisMonth: Int = 0

    // MARK: - Usage Tracking (free — lifetime)
    private(set) var lifetimeVideoAnalyses: Int = 0
    private(set) var lifetimeChatMessages: Int = 0

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
        if isSubscribed {
            return videoAnalysesThisMonth < videoAnalysisLimitPaid
        } else {
            return lifetimeVideoAnalyses < videoAnalysisLimitFree
        }
    }

    var canSendChat: Bool {
        if isSubscribed {
            return chatMessagesThisMonth < chatMessageLimitPaid
        } else {
            return lifetimeChatMessages < chatMessageLimitFree
        }
    }

    var canStartConversation: Bool {
        if isSubscribed {
            return conversationsThisMonth < conversationLimitPaid
        } else {
            return true // free users limited by message counts, not conversations
        }
    }

    var remainingVideoAnalyses: Int {
        if isSubscribed {
            return max(0, videoAnalysisLimitPaid - videoAnalysesThisMonth)
        } else {
            return max(0, videoAnalysisLimitFree - lifetimeVideoAnalyses)
        }
    }

    var remainingChatMessages: Int {
        if isSubscribed {
            return max(0, chatMessageLimitPaid - chatMessagesThisMonth)
        } else {
            return max(0, chatMessageLimitFree - lifetimeChatMessages)
        }
    }

    /// Display limit for the current tier
    var videoAnalysisLimit: Int {
        isSubscribed ? videoAnalysisLimitPaid : videoAnalysisLimitFree
    }

    var chatMessageLimit: Int {
        isSubscribed ? chatMessageLimitPaid : chatMessageLimitFree
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
        if isSubscribed {
            resetMonthIfNeeded()
            videoAnalysesThisMonth += 1
            UserDefaults.standard.set(videoAnalysesThisMonth, forKey: "video_analysis_count")
        } else {
            lifetimeVideoAnalyses += 1
            UserDefaults.standard.set(lifetimeVideoAnalyses, forKey: "lifetime_video_analyses")
        }
    }

    func incrementChatMessage() {
        if isSubscribed {
            resetMonthIfNeeded()
            chatMessagesThisMonth += 1
            UserDefaults.standard.set(chatMessagesThisMonth, forKey: "chat_message_count")
        } else {
            lifetimeChatMessages += 1
            UserDefaults.standard.set(lifetimeChatMessages, forKey: "lifetime_chat_messages")
        }
    }

    func incrementConversation() {
        resetMonthIfNeeded()
        conversationsThisMonth += 1
        UserDefaults.standard.set(conversationsThisMonth, forKey: "conversation_count")
    }

    private func resetMonthIfNeeded() {
        let currentMonth = Calendar.current.component(.month, from: Date())
        let currentYear = Calendar.current.component(.year, from: Date())
        let storedMonth = UserDefaults.standard.integer(forKey: "video_analysis_month")
        let storedYear = UserDefaults.standard.integer(forKey: "video_analysis_year")

        if currentMonth != storedMonth || currentYear != storedYear {
            videoAnalysesThisMonth = 0
            chatMessagesThisMonth = 0
            conversationsThisMonth = 0
            UserDefaults.standard.set(0, forKey: "video_analysis_count")
            UserDefaults.standard.set(0, forKey: "chat_message_count")
            UserDefaults.standard.set(0, forKey: "conversation_count")
            UserDefaults.standard.set(currentMonth, forKey: "video_analysis_month")
            UserDefaults.standard.set(currentYear, forKey: "video_analysis_year")
        }
    }

    private func loadUsageData() {
        resetMonthIfNeeded()
        videoAnalysesThisMonth = UserDefaults.standard.integer(forKey: "video_analysis_count")
        chatMessagesThisMonth = UserDefaults.standard.integer(forKey: "chat_message_count")
        conversationsThisMonth = UserDefaults.standard.integer(forKey: "conversation_count")
        lifetimeVideoAnalyses = UserDefaults.standard.integer(forKey: "lifetime_video_analyses")
        lifetimeChatMessages = UserDefaults.standard.integer(forKey: "lifetime_chat_messages")
    }

    // MARK: - Fetch Offerings

    @MainActor
    func fetchOfferings() async {
        do {
            let rcOfferings = try await Purchases.shared.offerings()
            offerings = rcOfferings

            if let current = rcOfferings.current {
                monthlyPackage = current.monthly
                yearlyPackage = current.annual
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
