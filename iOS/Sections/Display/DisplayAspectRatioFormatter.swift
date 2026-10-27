import Device

enum DisplayAspectRatioFormatter {
    static func format(width: Int, height: Int) -> String {
        guard width > 0, height > 0 else { return "Unknown" }
        return DisplayResolution(width: width, height: height).formattedAspectRatio
    }
}
