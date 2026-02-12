import SwiftUI
import PhotosUI
import UniformTypeIdentifiers

struct VideoPicker: UIViewControllerRepresentable {
    @Environment(\.dismiss) private var dismiss
    var onPick: (URL) -> Void

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration(photoLibrary: .shared())
        config.filter = .videos
        config.selectionLimit = 1
        config.preferredAssetRepresentationMode = .current

        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(onPick: onPick, dismiss: dismiss)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let onPick: (URL) -> Void
        let dismiss: DismissAction

        init(onPick: @escaping (URL) -> Void, dismiss: DismissAction) {
            self.onPick = onPick
            self.dismiss = dismiss
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            guard let provider = results.first?.itemProvider else {
                dismiss()
                return
            }

            // Try loading as movie
            let movieType = UTType.movie.identifier

            if provider.hasItemConformingToTypeIdentifier(movieType) {
                provider.loadFileRepresentation(forTypeIdentifier: movieType) { [weak self] url, error in
                    guard let self else { return }

                    if let url {
                        let tempURL = FileManager.default.temporaryDirectory
                            .appendingPathComponent(UUID().uuidString)
                            .appendingPathExtension(url.pathExtension.isEmpty ? "mov" : url.pathExtension)

                        do {
                            try FileManager.default.copyItem(at: url, to: tempURL)
                            DispatchQueue.main.async {
                                self.onPick(tempURL)
                                self.dismiss()
                            }
                        } catch {
                            DispatchQueue.main.async {
                                self.dismiss()
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.dismiss()
                        }
                    }
                }
            } else {
                dismiss()
            }
        }
    }
}
