import SwiftUI

@Observable
class SettingsViewModel {
    var hasAPIKey: Bool
    var showAPIKeySetup = false
    var showClearMemoryConfirmation = false
    var showResetConfirmation = false

    init() {
        self.hasAPIKey = KeychainManager.hasAPIKey
    }

    func refreshAPIKeyStatus() {
        hasAPIKey = KeychainManager.hasAPIKey
    }

    func deleteAPIKey() {
        KeychainManager.deleteAPIKey()
        hasAPIKey = false
    }
}
