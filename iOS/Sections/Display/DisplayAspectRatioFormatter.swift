import Foundation

enum DisplayAspectRatioFormatter {
    static func format(width: Int, height: Int) -> String {
        guard width > 0, height > 0 else { return "Unknown" }

        let ratio = Double(height) / Double(width)
        let conventionalRatios: [(height: Double, width: Double)] = [
            (19.5, 9), (16, 9), (16, 10), (3, 2), (4, 3), (5, 4), (1, 1)
        ]

        // Native panel dimensions can differ slightly from conventional display ratios
        if let closest = conventionalRatios.min(by: {
            abs(ratio - $0.height / $0.width) < abs(ratio - $1.height / $1.width)
        }), abs(ratio / (closest.height / closest.width) - 1) < 0.005 {
            let format = FloatingPointFormatStyle<Double>.number.precision(.fractionLength(0...1))
            return "\(closest.height.formatted(format)) : \(closest.width.formatted(format))"
        }

        if max(width, height) <= 20 {
            return "\(height) : \(width)"
        }

        return "\(ratio.formatted(.number.precision(.fractionLength(0...2)))) : 1"
    }
}
