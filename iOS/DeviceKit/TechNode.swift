import DeviceKit

// Sources
// https://phonedb.net

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
        case .s1: "28 nm" // https://phonedb.net/index.php?m=processor&id=599&c=apple_s1_apl0778_s7002
        case .s1P: "28 nm" // -
        case .s2: "16 nm" // -
        case .s3: "16 nm" // -
        case .s4: "7 nm (N7)" // https://phonedb.net/index.php?m=processor&id=771&c=apple_s4_tmjr65_t8006
        case .s5: "7 nm (N7)" // https://phonedb.net/index.php?m=processor&id=810&c=apple_s5_apl1w82_t8006
        case .s6: "7 nm (N7P)" // https://phonedb.net/index.php?m=processor&id=899&c=apple_s6_tmli30_t8301__turks
        case .s7: "7 nm (N7P)" // https://phonedb.net/index.php?m=processor&id=900&c=apple_s7_apl1w86_t8301__turks
        case .s8: "7 nm (N7P)" // https://phonedb.net/index.php?m=processor&id=907&c=apple_s8_t8301
        case .s9: "5 nm (N5P)" // https://phonedb.net/index.php?m=processor&id=996&c=apple_s9_apl1w15_t8310
        case .s10: "4 nm" // https://phonedb.net/index.php?m=processor&id=997&c=apple_s10_apl1w15_t8310
#endif
        case .unknown: "Unknown"
        @unknown default: "-"
        }
    }
}
