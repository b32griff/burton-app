import SwiftUI
import UIKit

struct VideoRecorder: UIViewControllerRepresentable {
    @Environment(\.dismiss) private var dismiss
    var onRecord: (URL) -> Void

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.mediaTypes = ["public.movie"]
        picker.videoMaximumDuration = 30
        picker.videoQuality = .typeMedium
        picker.cameraCaptureMode = .video
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(onRecord: onRecord, dismiss: dismiss)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let onRecord: (URL) -> Void
        let dismiss: DismissAction

        init(onRecord: @escaping (URL) -> Void, dismiss: DismissAction) {
            self.onRecord = onRecord
            self.dismiss = dismiss
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let videoURL = info[.mediaURL] as? URL {
                // Copy to temp so the original isn't cleaned up
                let tempURL = FileManager.default.temporaryDirectory
                    .appendingPathComponent(UUID().uuidString)
                    .appendingPathExtension("mov")
                do {
                    try FileManager.default.copyItem(at: videoURL, to: tempURL)
                    onRecord(tempURL)
                } catch {
                    // Fall through to dismiss
                }
            }
            dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss()
        }
    }
}
