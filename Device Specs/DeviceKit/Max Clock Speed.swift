import DeviceKit

extension Device.CPU {
    var maxClockSpeed: String {
        switch self {
#if os(iOS) || os(tvOS)
        case .a4: "0.8 GHz to 1 GHz"
        case .a5: "0.8 GHz to 1 GHz"
        case .a5X: "1 GHz"
        case .a6: "1.3 GHz"
        case .a6X: "1.4 GHz"
        case .a7: "1.3 GHz to 1.4 GHz"
        case .a8: "1.1 GHz to 1.5 GHz"
        case .a8X: "1.5 GHz"
        case .a9: "1.85 GHz"
        case .a9X: "2.16 GHz to 2.26 GHz"
        case .a10Fusion: "2.36 GHz"
        case .a10XFusion: "2.38 GHz"
        case .a11Bionic: "2.38 GHz"
        case .a12Bionic: "2.49 GHz"
        case .a12XBionic: "2.49 GHz"
        case .a12ZBionic: "2.49 GHz"
        case .a13Bionic: "2.65 GHz"
        case .a14Bionic: "3 GHz"
        case .a15Bionic: "3.23 GHz"
        case .a16Bionic: "2.02 GHz to 3.46 GHz"
        case .a17Pro: "3.78 GHz"
        case .a18: "4.04 GHz"
        case .a18Pro: "4.04 GHz"
        case .m1: "3.2 GHz"
        case .m2: "3.5 GHz (Max & Ultra - 3.67 GHz)"
        case .m3: "4.05 GHz"
        case .m4: "4.41 GHz"
#elseif os(watchOS)
        case .s1: "0.52 GHz"
        case .s1P: "0.52 GHz"
        case .s2: "0.52 GHz"
        case .s3: "0.78 (Estimated)"
        case .s4: "1.59 GHz"
        case .s5: "1.59 GHz"
        case .s6: "1.8 GHz"
        case .s7: "1.8 GHz"
        case .s8: "1.8 GHz"
        case .s9: "-"
        case .s10: "-"
#endif
        case .unknown:
            "Unknown"
        }
    }
}
