import DeviceKit

// Sources
// https://phonedb.net

extension Device.CPU {
    var maxClockSpeed: String {
        switch self {
#if os(iOS) || os(tvOS)
        case .a4: "0.8 to 1 GHz" // https://phonedb.net/index.php?m=processor&id=234&c=samsung-intrinsity_apple_a4_apl0398_s5l8930
        case .a5: "0.8 to 1.2 GHz" // https://phonedb.net/index.php?m=processor&id=282&c=apple_a5_apl0498_s5l8940
        case .a5X: "1 GHz" // https://phonedb.net/index.php?m=processor&id=335&c=apple_a5x_apl5498_s5l8945x
        case .a6: "1.3 GHz" // https://phonedb.net/index.php?m=processor&id=356&c=apple_a6_apl0598_s5l8950x__bali
        case .a6X: "1.4 GHz" // https://phonedb.net/index.php?m=processor&id=366&c=apple_a6x_apl5598_s5l8955x__bali
        case .a7: "1.4 to 1.5 GHz" // https://phonedb.net/index.php?m=processor&id=433&c=apple_a7_apl5698_s5l8965x__alcatraz https://phonedb.net/index.php?m=processor&id=423&c=apple_a7_apl0698_s5l8960x__alcatraz
        case .a8: "1.51 GHz" // https://phonedb.net/index.php?m=processor&id=531&c=apple_a8_apl1011_t7000__fiji
        case .a8X: "1.5 GHz" // https://phonedb.net/index.php?m=processor&id=548&c=apple_a8x_apl1012_t7001__capri
        case .a9: "1.6 to 1.84 GHz" // https://phonedb.net/index.php?m=processor&id=626&c=apple_a9_apl0898_s8000__maui
        case .a9X: "2.26 GHz" // https://phonedb.net/index.php?m=processor&id=629&c=apple_a9x_apl1021_s8001__elba
        case .a10Fusion: "0.396 to 2.37 GHz" // https://phonedb.net/index.php?m=processor&id=677&c=apple_a10_fusion_apl1w24_t8010__cayman
        case .a10XFusion: "2.38 GHz" // https://phonedb.net/index.php?m=processor&id=719&c=apple_a10x_fusion_apl1071_t8011__myst
        case .a11Bionic: "2.38 GHz"
        case .a12Bionic: "2.49 GHz"
        case .a12XBionic: "2.49 GHz"
        case .a12ZBionic: "2.49 GHz"
        case .a13Bionic: "2.65 GHz"
        case .a14Bionic: "3 GHz"
        case .a15Bionic: "3.23 GHz"
        case .a16Bionic: "2.02 to 3.46 GHz"
        case .a17Pro: "3.78 GHz"
        case .a18: "4.04 GHz"
        case .a18Pro: "4.04 GHz"
        
            // https://phonedb.net/index.php?m=processor&id=893&c=apple_m1_lite_apl1102_t8103__tonga
            // https://phonedb.net/index.php?m=processor&id=861&c=apple_m1_apl1102_t8103__tonga
        case .m1: "3.228 GHz"
            
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
