#if canImport(NearbyInteraction)
import NearbyInteraction
#endif

final class DeviceInfo {
    static var isUltraWidebandAvailable: Bool {
#if canImport(NearbyInteraction)
        NISession.deviceCapabilities.supportsPreciseDistanceMeasurement
#else
        false
#endif
    }
}
