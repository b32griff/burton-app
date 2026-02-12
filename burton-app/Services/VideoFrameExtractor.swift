import AVFoundation
import UIKit

struct VideoFrameExtractor {
    static func extractKeyFrames(from url: URL, count: Int = 4, maxDimension: CGFloat = 1024) async throws -> [Data] {
        let asset = AVURLAsset(url: url)
        let duration = try await asset.load(.duration)
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

            let (cgImage, _) = try await generator.image(at: time)
            let uiImage = UIImage(cgImage: cgImage)

            if let jpegData = uiImage.jpegData(compressionQuality: 0.7) {
                frames.append(jpegData)
            }
        }

        return frames
    }
}
