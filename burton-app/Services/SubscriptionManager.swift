import Foundation
import StoreKit

@Observable
class SubscriptionManager {
    // MARK: - Product State
    var products: [Product] = []
    var monthlyProduct: Product?
    var yearlyProduct: Product?

    // MARK: - Subscription State
    var isSubscribed = false
    var isInTrialPeriod = false
    var hasCheckedStatus = false

    // MARK: - UI State
    var isLoading = false
    var purchaseError: String?

    // MARK: - Private
    private var updateListenerTask: Task<Void, Never>?
    private let productIDs: Set<String> = ["monthly_sub", "yearly_sub"]

    init() {
        updateListenerTask = listenForTransactionUpdates()
        Task {
            await loadProducts()
            await updateSubscriptionStatus()
        }
    }

    deinit {
        updateListenerTask?.cancel()
    }

    // MARK: - Load Products

    @MainActor
    func loadProducts() async {
        do {
            let storeProducts = try await Product.products(for: productIDs)
            products = storeProducts.sorted { $0.price < $1.price }
            monthlyProduct = storeProducts.first { $0.id == "monthly_sub" }
            yearlyProduct = storeProducts.first { $0.id == "yearly_sub" }
        } catch {
            purchaseError = "Failed to load subscription options."
        }
    }

    // MARK: - Purchase

    @MainActor
    func purchase(_ product: Product) async {
        isLoading = true
        purchaseError = nil

        do {
            let result = try await product.purchase()
            switch result {
            case .success(let verification):
                let transaction = try checkVerified(verification)
                await transaction.finish()
                await updateSubscriptionStatus()
            case .userCancelled:
                break
            case .pending:
                purchaseError = "Purchase is pending approval."
            @unknown default:
                break
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

        try? await AppStore.sync()
        await updateSubscriptionStatus()

        if !isSubscribed {
            purchaseError = "No active subscription found."
        }

        isLoading = false
    }

    // MARK: - Subscription Status

    @MainActor
    func updateSubscriptionStatus() async {
        var foundActive = false

        for await result in Transaction.currentEntitlements {
            if let transaction = try? checkVerified(result) {
                if productIDs.contains(transaction.productID) {
                    foundActive = true
                    if let offer = transaction.offer,
                       offer.type == .introductory {
                        isInTrialPeriod = true
                    } else {
                        isInTrialPeriod = false
                    }
                }
            }
        }

        isSubscribed = foundActive
        if !foundActive {
            isInTrialPeriod = false
        }
        hasCheckedStatus = true
    }

    // MARK: - Transaction Listener

    private func listenForTransactionUpdates() -> Task<Void, Never> {
        Task.detached { [weak self] in
            for await result in Transaction.updates {
                if let transaction = try? self?.checkVerified(result) {
                    await transaction.finish()
                    await self?.updateSubscriptionStatus()
                }
            }
        }
    }

    // MARK: - Verification

    private nonisolated func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .verified(let value):
            return value
        case .unverified(_, let error):
            throw error
        }
    }
}
