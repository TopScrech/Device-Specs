#if canImport(NearbyInteraction)
import NearbyInteraction

final class DeviceInfo {
    static var isUltraWidebandAvailable: Bool {
        NISession.deviceCapabilities.supportsPreciseDistanceMeasurement
    }
}

#endif
