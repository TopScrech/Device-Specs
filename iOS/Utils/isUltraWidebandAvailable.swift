#if canImport(NearbyInteraction)
import NearbyInteraction
#endif

final class DeviceCapabilities {
    static var isUltraWidebandAvailable: Bool {
        uwbSupport != .notSupported
    }

    static var uwbSupport: UWBSupport {
#if canImport(NearbyInteraction)
        let capabilities = NISession.deviceCapabilities

        guard capabilities.supportsPreciseDistanceMeasurement else {
            return .notSupported
        }

        return capabilities.supportsExtendedDistanceMeasurement ? .gen2 : .gen1
#else
        .notSupported
#endif
    }
}
