import SwiftUI

struct APIKeySetupView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var apiKey = ""
    @State private var isValidating = false
    @State private var errorMessage: String?
    @State private var isValid = false
    var onComplete: (() -> Void)?

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    Spacer().frame(height: 20)

                    Image(systemName: "key.fill")
                        .font(.system(size: 50))
                        .foregroundStyle(.golfGreen)

                    Text("Connect to Claude")
                        .font(.title2.bold())

                    Text("Enter your Anthropic API key to power your AI swing coach. Your key is stored securely on-device.")
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)

                    VStack(alignment: .leading, spacing: 8) {
                        SecureField("sk-ant-...", text: $apiKey)
                            .textFieldStyle(.roundedBorder)
                            .textContentType(.password)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)

                        if let error = errorMessage {
                            Text(error)
                                .font(.caption)
                                .foregroundStyle(.red)
                        }
                    }
                    .padding(.horizontal, 24)

                    Button {
                        validateAndSave()
                    } label: {
                        HStack {
                            if isValidating {
                                ProgressView()
                                    .tint(.white)
                            }
                            Text(isValidating ? "Validating..." : "Save API Key")
                                .font(.headline)
                        }
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.golfGreen, in: RoundedRectangle(cornerRadius: 14))
                    }
                    .disabled(apiKey.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || isValidating)
                    .padding(.horizontal, 24)

                    Link(destination: URL(string: "https://console.anthropic.com/settings/keys")!) {
                        Label("Get an API key from Anthropic", systemImage: "arrow.up.right.square")
                            .font(.subheadline)
                    }

                    Spacer()
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    if onComplete == nil {
                        Button("Skip") {
                            dismiss()
                        }
                    }
                }
            }
        }
    }

    private func validateAndSave() {
        let key = apiKey.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !key.isEmpty else { return }

        isValidating = true
        errorMessage = nil

        Task {
            let valid = await ClaudeAPIService.validateAPIKey(key)

            await MainActor.run {
                isValidating = false
                if valid {
                    let saved = KeychainManager.saveAPIKey(key)
                    if saved {
                        isValid = true
                        if let onComplete {
                            onComplete()
                        } else {
                            dismiss()
                        }
                    } else {
                        errorMessage = "Failed to save key securely. Please try again."
                    }
                } else {
                    errorMessage = "Invalid API key. Please check and try again."
                }
            }
        }
    }
}
