import AVFoundation
import UIKit

struct VideoFrameExtractor {

    /// Extracts 12 weighted key frames from a golf swing video.
    /// More frames are concentrated around the critical phases (downswing, impact, early follow-through)
    /// where the swing moves fastest and the most important positions occur.
    static func extractKeyFrames(from url: URL, maxDimension: CGFloat = 640) async throws -> [Data] {
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
    // Frame distribution (12 frames):
    //  0.00  Setup/Address
    //  0.10  Early Takeaway
    //  0.25  Mid-Backswing
    //  0.38  Top of Backswing
    //  0.48  Transition (top → down)
    //  0.56  Early Downswing
    //  0.64  Late Downswing
    //  0.72  Impact Zone (pre-impact)
    //  0.78  Impact
    //  0.84  Early Follow-through
    //  0.92  Late Follow-through
    //  1.00  Finish
    private static let weightedPositions: [Double] = [
        0.00, 0.10, 0.25, 0.38, 0.48, 0.56, 0.64, 0.72, 0.78, 0.84, 0.92, 1.00
    ]

    static let phaseLabels: [String] = [
        "Setup/Address",
        "Early Takeaway",
        "Mid-Backswing",
        "Top of Backswing",
        "Transition",
        "Early Downswing",
        "Late Downswing",
        "Pre-Impact",
        "Impact",
        "Early Follow-through",
        "Late Follow-through",
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
        // Tighter tolerance for more precise frame capture around impact
        generator.requestedTimeToleranceBefore = CMTime(seconds: 0.05, preferredTimescale: 600)
        generator.requestedTimeToleranceAfter = CMTime(seconds: 0.05, preferredTimescale: 600)

        var frames: [Data] = []

        for fraction in weightedPositions {
            let time = CMTime(seconds: totalSeconds * fraction, preferredTimescale: 600)

            let cgImage = try generator.copyCGImage(at: time, actualTime: nil)
            let uiImage = UIImage(cgImage: cgImage)

            if let jpegData = uiImage.jpegData(compressionQuality: 0.5) {
                frames.append(jpegData)
            }
        }

        return frames
    }
}
