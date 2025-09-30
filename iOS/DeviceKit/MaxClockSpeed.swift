import DeviceKit

// Sources
// https://phonedb.net

extension Device.CPU {
    var maxClockSpeed: String {
        switch self {
#if os(iOS) || os(tvOS)
        case .a4, .a5: "0.8 GHz to 1 GHz"
        case .a5X: "1 GHz"
        case .a6: "1.3 GHz"
        case .a6X: "1.4 GHz"
        case .a7: "1.3 to 1.4 GHz"
        case .a8: "1.1 to 1.5 GHz"
        case .a8X: "1.5 GHz"
        case .a9: "1.85 GHz"
        case .a9X: "2.16 to 2.26 GHz"
        case .a10Fusion: "2.36 GHz"
        case .a10XFusion, .a11Bionic: "2.38 GHz"
        case .a12Bionic, .a12XBionic, .a12ZBionic: "2.49 GHz"
        case .a13Bionic: "2.65 GHz"
        case .a14Bionic: "3 GHz"
        case .a15Bionic: "3.23 GHz"
        case .a16Bionic: "2.02 to 3.46 GHz"
        case .a17Pro: "3.78 GHz"
        case .a18, .a18Pro: "4.04 GHz"
        case .m1: "3.2 GHz"
        case .m2: "3.5 GHz (Max & Ultra - 3.67 GHz)"
        case .m3: "4.05 GHz"
        case .m4: "4.41 GHz"
#elseif os(watchOS)
        case .s1: "0.52 GHz" // https://phonedb.net/index.php?m=processor&id=599&c=apple_s1_apl0778_s7002
        case .s1P: "0.52 GHz" // https://phonedb.net/index.php?m=processor&id=680&c=apple_s1p_t8002
        case .s2: "0.78 GHz" // https://phonedb.net/index.php?m=processor&id=679&c=apple_s2_tmgk97_t8002
        case .s3: "0.78 (Estimated)" // -
        case .s4: "1.59 GHz" // https://phonedb.net/index.php?m=processor&id=771&c=apple_s4_tmjr65_t8006
        case .s5: "1.59 GHz" // https://phonedb.net/index.php?m=processor&id=810&c=apple_s5_apl1w82_t8006
        case .s6: "1.73 GHz" // https://phonedb.net/index.php?m=processor&id=899&c=apple_s6_tmli30_t8301__turks
        case .s7: "1.73 GHz" // https://phonedb.net/index.php?m=processor&id=900&c=apple_s7_apl1w86_t8301__turks
        case .s8: "1.73 GHz" // https://phonedb.net/index.php?m=processor&id=907&c=apple_s8_t8301
        case .s9: "2.02 GHz" // https://phonedb.net/index.php?m=processor&id=996&c=apple_s9_apl1w15_t8310
        case .s10: "2.02 GHz" // https://phonedb.net/index.php?m=processor&id=997&c=apple_s10_apl1w15_t8310
#endif
        case .unknown: "Unknown"
        @unknown default: "-"
        }
    }
}
