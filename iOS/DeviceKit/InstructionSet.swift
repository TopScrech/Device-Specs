import DeviceKit

// Sources
// https://phonedb.net

extension Device.CPU {
    var instructionSet: String {
        switch self {
#if os(iOS) || os(tvOS)
        case .a4, .a5, .a5X: "ARMv7-A"
        case .a6, .a6X: "ARMv7-A \"Swift\""
        case .a7, .a8, .a8X, .a9, .a9X: "ARMv8.0-A"
        case .a10Fusion, .a10XFusion: "ARMv8.1-A"
        case .a11Bionic: "ARMv8.2-A"
        case .a12Bionic, .a12XBionic, .a12ZBionic: "ARMv8.3-A"
        case .a13Bionic: "ARMv8.4-A"
        case .a14Bionic, .a15Bionic: "ARMv8.5-A"
        case .a16Bionic, .a17Pro: "ARMv8.6-A"
        case .a18, .a18Pro, .a19, .a19Pro: "ARMv9.2-A"
            
        case .m1: "ARMv8.4-A"
        case .m2, .m3: "ARMv8.6-A"
        case .m4: "ARMv9.2-A"
#elseif os(watchOS)
        case .s1: "ARMv7k" // https://phonedb.net/index.php?m=processor&id=599&c=apple_s1_apl0778_s7002
        case .s1P: "ARMv7" // https://phonedb.net/index.php?m=processor&id=680&c=apple_s1p_t8002
        case .s2: "ARMv7" // https://phonedb.net/index.php?m=processor&id=679&c=apple_s2_tmgk97_t8002
        case .s3: "ARMv7" // https://phonedb.net/index.php?m=processor&id=745&c=apple_s3_tmhu50_t8004
        case .s2: "ARMv7" // https://phonedb.net/index.php?m=processor&id=679&c=apple_s2_tmgk97_t8002
        case .s3: "ARMv7" // https://phonedb.net/index.php?m=processor&id=745&c=apple_s3_tmhu50_t8004
        case .s4: "ARMv8.3-A (A32, A64)" // https://phonedb.net/index.php?m=processor&id=771&c=apple_s4_tmjr65_t8006
        case .s5: "ARMv8-A (A32, A64)" // https://phonedb.net/index.php?m=processor&id=810&c=apple_s5_apl1w82_t8006
        case .s6: "ARMv8.4-A (A32, A64)" // https://phonedb.net/index.php?m=processor&id=899&c=apple_s6_tmli30_t8301__turks
        case .s7: "ARMv8.4-A (A32, A64)" // https://phonedb.net/index.php?m=processor&id=900&c=apple_s7_apl1w86_t8301__turks
        case .s8: "ARMv8.4-A (A32, A64)" // https://phonedb.net/index.php?m=processor&id=907&c=apple_s8_t8301
        case .s9: "ARMv8.6-A (A32, A64)" // https://phonedb.net/index.php?m=processor&id=996&c=apple_s9_apl1w15_t8310
        case .s10: "ARMv8.6-A (A32, A64)" // https://phonedb.net/index.php?m=processor&id=997&c=apple_s10_apl1w15_t8310
#endif
        case .unknown: "Unknown"
        @unknown default: "-"
        }
    }
}
