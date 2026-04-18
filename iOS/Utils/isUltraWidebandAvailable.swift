#if canImport(NearbyInteraction)
import NearbyInteraction
#endif

final class DeviceCapabilities {
    static var isUltraWidebandAvailable: Bool {
#if canImport(NearbyInteraction)
        NISession.deviceCapabilities.supportsPreciseDistanceMeasurement
#else
        false
#endif
    }
}
