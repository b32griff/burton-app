import AVFoundation
import UIKit

struct VideoFrameExtractor {
    static func extractKeyFrames(from url: URL, count: Int = 8, maxDimension: CGFloat = 1280) async throws -> [Data] {
        // Run on a background thread to avoid blocking and potential deadlocks
        // with AVAssetImageGenerator's async API
        return try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.global(qos: .userInitiated).async {
                do {
                    let frames = try extractFramesSync(from: url, count: count, maxDimension: maxDimension)
                    continuation.resume(returning: frames)
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    private static func extractFramesSync(from url: URL, count: Int, maxDimension: CGFloat) throws -> [Data] {
        let asset = AVURLAsset(url: url)
        let duration = asset.duration
        let totalSeconds = CMTimeGetSeconds(duration)

        guard totalSeconds > 0 else { return [] }

        let generator = AVAssetImageGenerator(asset: asset)
        generator.appliesPreferredTrackTransform = true
        generator.maximumSize = CGSize(width: maxDimension, height: maxDimension)
        generator.requestedTimeToleranceBefore = CMTime(seconds: 0.1, preferredTimescale: 600)
        generator.requestedTimeToleranceAfter = CMTime(seconds: 0.1, preferredTimescale: 600)

        var frames: [Data] = []

        for i in 0..<count {
            let fraction = Double(i) / Double(max(count - 1, 1))
            let time = CMTime(seconds: totalSeconds * fraction, preferredTimescale: 600)

            let cgImage = try generator.copyCGImage(at: time, actualTime: nil)
            let uiImage = UIImage(cgImage: cgImage)

            if let jpegData = uiImage.jpegData(compressionQuality: 0.85) {
                frames.append(jpegData)
            }
        }

        return frames
    }
}
