import DeviceKit

// Sources
// https://theapplewiki.com/wiki/Application_Processor
// https://phonedb.net

extension Device.CPU {
    var memoryType: String {
        switch self {
#if os(iOS) || os(tvOS)
        case .a4: "-"
        case .a5: "-"
        case .a5X: "-"
        case .a6: "-"
        case .a6X: "-"
        case .a7: "LPDDR3"
        case .a8, .a8X: "LPDDR3-1600"
        case .a9, .a9X: "LPDDR4-3200"
        case .a10Fusion, .a10XFusion: "LPDDR4-3200"
        case .a11Bionic, .a12Bionic, .a12XBionic, .a12ZBionic, .a13Bionic, .a14Bionic, .a15Bionic: "LPDDR4X-4266"
        case .a16Bionic, .a17Pro: "LPDDR5-6400"
        case .a18, .a18Pro: "LPDDR5X-8533"
        case .a19Pro: "LPDDR5X"
            
        case .m1: "LPDDR4X-4266 2133 MHz (Pro, Max, Ultra - LPDDR4X-6400 (3200 MHz))"
        case .m2, .m3: "LPDDR5-6400"
        case .m4: "LPDDR5-7500" // Pro, Max, Ultra - ???
#elseif os(watchOS)
        case .s1: "LPDDR3" // https://phonedb.net/index.php?m=processor&id=599&c=apple_s1_apl0778_s7002
        case .s1P: "LPDDR2, LPDDR3" // https://phonedb.net/index.php?m=processor&id=680&c=apple_s1p_t8002
        case .s2: "LPDDR3, LPDDR4" // https://phonedb.net/index.php?m=processor&id=679&c=apple_s2_tmgk97_t8002
        case .s3: "LPDDR3, LPDDR4" // https://phonedb.net/index.php?m=processor&id=745&c=apple_s3_tmhu50_t8004
        case .s4: "LPDDR4, LPDDR4X" // https://phonedb.net/index.php?m=processor&id=771&c=apple_s4_tmjr65_t8006
        case .s5: "LPDDR4, LPDDR4X" // https://phonedb.net/index.php?m=processor&id=810&c=apple_s5_apl1w82_t8006
        case .s6: "LPDDR4X" // https://phonedb.net/index.php?m=processor&id=899&c=apple_s6_tmli30_t8301__turks
        case .s7: "LPDDR4X" // https://phonedb.net/index.php?m=processor&id=900&c=apple_s7_apl1w86_t8301__turks
        case .s8: "LPDDR4X" // https://phonedb.net/index.php?m=processor&id=907&c=apple_s8_t8301
        case .s9: "LPDDR4X, LPDDR5" // https://phonedb.net/index.php?m=processor&id=996&c=apple_s9_apl1w15_t8310
        case .s10: "LPDDR4X, LPDDR5" // https://phonedb.net/index.php?m=processor&id=997&c=apple_s10_apl1w15_t8310
#endif
        case .unknown: "Unknown"
        @unknown default: "-"
        }
    }
}
