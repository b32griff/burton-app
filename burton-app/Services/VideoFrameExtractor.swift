import AVFoundation
import UIKit

struct VideoFrameExtractor {

    /// Extracts 10 weighted key frames from a golf swing video.
    /// Extra frames are concentrated in the transition-through-impact zone (45-80% of the swing)
    /// where the swing moves fastest and the most important checkpoint positions occur.
    static func extractKeyFrames(from url: URL, maxDimension: CGFloat = 1024) async throws -> [Data] {
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

    // Weighted frame positions as fractions of total video duration.
    // A typical golf swing video: setup → takeaway → top → transition → downswing → impact → follow-through → finish
    //
    // Frame distribution (10 frames) — extra density in the transition-through-impact zone (45-80%)
    // where the swing moves fastest and the most important checkpoint positions occur:
    //  0.00  Setup/Address
    //  0.15  Takeaway
    //  0.32  Mid-Backswing
    //  0.45  Top of Backswing
    //  0.55  Transition
    //  0.65  Downswing
    //  0.74  Pre-Impact
    //  0.80  Impact
    //  0.90  Follow-through
    //  1.00  Finish
    private static let weightedPositions: [Double] = [
        0.00, 0.15, 0.32, 0.45, 0.55, 0.65, 0.74, 0.80, 0.90, 1.00
    ]

    static let phaseLabels: [String] = [
        "Setup/Address",
        "Takeaway",
        "Mid-Backswing",
        "Top of Backswing",
        "Transition",
        "Downswing",
        "Pre-Impact",
        "Impact",
        "Follow-through",
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
