import DeviceKit

extension Device.CPU {
    var techNode: String {
        switch self {
#if os(iOS) || os(tvOS)
        case .a4, .a5X: "45 nm"
        case .a5: "45-32 nm"
        case .a6, .a6X: "32 nm"
        case .a7: "28 nm"
        case .a8: "22 nm"
        case .a8X: "20 nm"
        case .a9: "14 nm"
        case .a9X: "16 nm"
        case .a10Fusion: "14 nm"
        case .a10XFusion, .a11Bionic: "10 nm"
        case .a12Bionic, .a12XBionic, .a12ZBionic: "7 nm (N7)"
        case .a13Bionic: "7 nm (N7P)"
        case .a14Bionic, .m1: "5 nm (N5)"
        case .a15Bionic, .m2: "5 nm (N5P)"
        case .a16Bionic: "4 nm (N4P)"
        case .m3: "3 nm (N3)"
        case .a17Pro: "3 nm (N3B)"
        case .a18, .a18Pro, .m4: "3 nm (N3E)"
        case .a19, .a19Pro: "3 nm (N3P)"
#elseif os(watchOS)
        case .s1, .s1P: "28 nm"
        case .s2, .s3: "16 nm"
        case .s4, .s5: "7 nm (N7)"
        case .s6, .s7, .s8: "7 nm (N7P)"
        case .s9: "5 nm (N5P)"
        case .s10: "-"
#endif
        case .unknown: "Unknown"
        @unknown default: "-"
        }
    }
}
