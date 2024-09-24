import DeviceKit

extension Device.CPU {
    var nanometers: String {
        switch self {
#if os(iOS) || os(tvOS)
        case .a4: "45"
        case .a5: "45-32"
        case .a5X: "45"
        case .a6: "32"
        case .a6X: "32"
        case .a7: "28"
        case .a8: "22"
        case .a8X: "20"
        case .a9: "14"
        case .a9X: "16"
        case .a10Fusion: "14"
        case .a10XFusion: "10"
        case .a11Bionic: "10"
        case .a12Bionic: "7"
        case .a12XBionic: "7"
        case .a12ZBionic: "7"
        case .a13Bionic: "7"
        case .a14Bionic: "5"
        case .a15Bionic: "5"
        case .a16Bionic: "4"
        case .a17Pro: "3"
        case .a18: "3"
        case .a18Pro: "3"
        case .m1: "5"
        case .m2: "5"
        case .m3: "3"
        case .m4: "3"
#elseif os(watchOS)
        case .s1: "28"
        case .s1P: "28"
        case .s2: "16"
        case .s3: "16"
        case .s4: "7"
        case .s5: "7"
        case .s6: "7"
        case .s7: "7"
        case .s8: "7"
        case .s9: "5"
        case .s10: "4"
#endif
        case .unknown:
            "Unknown"
        }
    }
}
