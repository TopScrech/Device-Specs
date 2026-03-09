import DeviceKit

extension Device {
    var hasMagsafe: Bool {
        switch self {
#if os(iOS)
        case .iPhone12, .iPhone12Mini, .iPhone12Pro, .iPhone12ProMax,
                .iPhone13, .iPhone13Mini, .iPhone13Pro, .iPhone13ProMax,
                .iPhone14, .iPhone14Plus, .iPhone14Pro, .iPhone14ProMax,
                .iPhone15, .iPhone15Plus, .iPhone15Pro, .iPhone15ProMax,
                .iPhone16, .iPhone16Plus, .iPhone16Pro, .iPhone16ProMax,
                .iPhone17, .iPhoneAir, .iPhone17Pro, .iPhone17ProMax,
                .iPhone17e:
            true
#endif
        default:
            false
        }
    }
}
