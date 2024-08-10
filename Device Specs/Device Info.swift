#if canImport(NearbyInteraction)
import NearbyInteraction

final class DeviceInfo {
    static var isUltraWidebandAvailable: Bool {
        if #available(iOS 16, watchOS 9, *) {
            NISession.deviceCapabilities.supportsPreciseDistanceMeasurement
        } else {
            NISession.isSupported
        }
    }
}

#endif
