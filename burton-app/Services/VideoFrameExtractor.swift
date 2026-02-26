import AVFoundation
import UIKit

struct VideoFrameExtractor {

    /// Extracts 6 weighted key frames from a golf swing video.
    /// Covers the critical checkpoint positions while keeping image token costs low.
    static func extractKeyFrames(from url: URL, maxDimension: CGFloat = 720) async throws -> [Data] {
        return try await withCheckedThrowingContinuation { continuation in
            DispatchQueue.global(qos: .userInitiated).async {
                do {
                    let frames = try extractWeightedFrames(from: url, maxDimension: maxDimension)
                    continuation.resume(returning: frames)
                } catch {
                    continuation.resume(throwing: error)
                }
            }
        }
    }

    // 6 frames covering the key swing checkpoints:
    //  0.00  Setup/Address
    //  0.30  Top of Backswing
    //  0.50  Transition
    //  0.70  Downswing
    //  0.82  Impact
    //  1.00  Finish
    private static let weightedPositions: [Double] = [
        0.00, 0.30, 0.50, 0.70, 0.82, 1.00
    ]

    static let phaseLabels: [String] = [
        "Setup/Address",
        "Top of Backswing",
        "Transition",
        "Downswing",
        "Impact",
        "Finish"
    ]

    private static func extractWeightedFrames(from url: URL, maxDimension: CGFloat) throws -> [Data] {
        let asset = AVURLAsset(url: url)
        let duration = asset.duration
        let totalSeconds = CMTimeGetSeconds(duration)

        guard totalSeconds > 0 else { return [] }

        let generator = AVAssetImageGenerator(asset: asset)
        generator.appliesPreferredTrackTransform = true
        generator.maximumSize = CGSize(width: maxDimension, height: maxDimension)
        // Tight tolerance for precise frame capture, especially around impact
        generator.requestedTimeToleranceBefore = CMTime(seconds: 0.03, preferredTimescale: 600)
        generator.requestedTimeToleranceAfter = CMTime(seconds: 0.03, preferredTimescale: 600)

        var frames: [Data] = []

        for fraction in weightedPositions {
            let time = CMTime(seconds: totalSeconds * fraction, preferredTimescale: 600)

            let cgImage = try generator.copyCGImage(at: time, actualTime: nil)
            let uiImage = UIImage(cgImage: cgImage)

            if let jpegData = uiImage.jpegData(compressionQuality: 0.55) {
                frames.append(jpegData)
            }
        }

        return frames
    }
}
