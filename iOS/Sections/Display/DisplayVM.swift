import SwiftUI
import Device

@Observable
final class DisplayVM {
#if os(iOS)
    @available(iOS 27.1, *)
    static func hingeStatusDescription(_ status: DeviceHinge.Status) -> LocalizedStringKey {
        switch status {
        case .closed: "Closed"
        case .partiallyOpen: "Partially open"
        case .fullyOpen: "Fully open"
        default: "Unknown"
        }
    }
#endif

    static var displays: [DeviceDisplay] { Device.current.displays ?? [] }

    static var diagonalSize: String {
        guard let display = Device.current.display else { return "Unknown" }
        return diagonalDescription(display)
    }

    static func diagonalDescription(_ display: DeviceDisplay) -> String {
        let diagonal = display.diagonal ?? display.estimatedDiagonal
        let value = diagonal.formatted(.number.precision(.fractionLength(0...2)))
        return display.diagonal == nil ? "≈\(value)\"" : "\(value)\""
    }

    static var pixelDencity: String? {
        Device.current.display.map { "\($0.ppi) PPI" }
    }

    static var resolution: String {
        if let resolution = Device.current.display?.resolution {
            return "\(resolution.width) x \(resolution.height)"
        }
#if os(iOS) || os(tvOS)
        if let bounds = activeScreen?.nativeBounds {
            return "\(Int(bounds.width)) x \(Int(bounds.height))"
        } else {
            return "Unknown"
        }
#elseif os(watchOS)
        let screen = WKInterfaceDevice.current()
        let bounds = screen.screenBounds
        return "\(Int(bounds.width * screen.screenScale)) x \(Int(bounds.height * screen.screenScale))"
#endif
    }

    static var refreshRate: String {
#if os(iOS) || os(tvOS)
        let value = activeScreen.map { String($0.maximumFramesPerSecond) } ?? "Unknown"
        return ValueStore.debugValue(value, override: "120")
#else
        return "Unknown"
#endif
    }

    static var roundedCorners: Bool { Device.current.has(.roundedDisplayCorners) }

    static var aspectRatio: String {
        guard let ratio = Device.current.display?.resolution.aspectRatio else { return "Unknown" }
        return DisplayAspectRatioFormatter.format(width: ratio.width, height: ratio.height)
    }

    /// Live brightness is exposed by iOS only, never a fabricated value on other platforms
    static var brightness: Double? {
#if os(iOS)
        activeScreen.map { Double($0.brightness) * 100 }
#else
        nil
#endif
    }

    static func setBrightness(_ percentage: Double) {
#if os(iOS) && !EXTENSION
        activeScreen?.brightness = CGFloat(min(max(percentage, 0), 100) / 100)
#endif
    }

#if os(iOS) || os(tvOS)
    private static var activeScreen: UIScreen? {
#if EXTENSION
        // Application extensions cannot enumerate UIApplication scenes
        return .main
#else
        let scenes = UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }
        return scenes.first { $0.activationState == .foregroundActive }?.screen ?? scenes.first?.screen
#endif
    }
#endif
}
