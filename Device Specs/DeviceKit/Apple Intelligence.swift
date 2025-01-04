import DeviceKit

extension Device {
    var supportsAppleIntelligence: Bool {
        switch self {
#if os(iOS)
        case .iPhone15Pro: true
        case .iPhone15ProMax: true
        case .iPhone16: true
        case .iPhone16Plus: true
        case .iPhone16Pro: true
        case .iPhone16ProMax: true
        case .iPadAir11M2: true
        case .iPadAir13M2: true
            //        case .iPadMini7: true
        case .iPadPro11Inch3: true
        case .iPadPro12Inch5: true
        case .iPadPro11Inch4: true
        case .iPadPro12Inch6: true
        case .iPadPro11M4: true
        case .iPadPro13M4: true
        case .homePod: false
#elseif os(tvOS)
        case .appleTVHD: false
        case .appleTV4K: false
        case .appleTV4K2: false
        case .appleTV4K3: false
#endif
        case .simulator: false
        case .unknown: false
        default: false
        }
    }
}
