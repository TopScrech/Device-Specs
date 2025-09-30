import DeviceKit

// Sources
// https://phonedb.net

extension Device.CPU {
    var techNode: String {
        switch self {
#if os(iOS) || os(tvOS)
        case .a4: "45 nm" // https://phonedb.net/index.php?m=processor&id=234&c=samsung-intrinsity_apple_a4_apl0398_s5l8930
            #warning("source says 45 nm, but I think it's 45-32 nm")
        case .a5: "45-32 nm" // https://phonedb.net/index.php?m=processor&id=282&c=apple_a5_apl0498_s5l8940
        case .a5X: "45 nm" // https://phonedb.net/index.php?m=processor&id=335&c=apple_a5x_apl5498_s5l8945x
        case .a6: "32 nm" // https://phonedb.net/index.php?m=processor&id=356&c=apple_a6_apl0598_s5l8950x__bali
        case .a6X: "32 nm" // https://phonedb.net/index.php?m=processor&id=366&c=apple_a6x_apl5598_s5l8955x__bali
        case .a7: "28 nm" // https://phonedb.net/index.php?m=processor&id=433&c=apple_a7_apl5698_s5l8965x__alcatraz https://phonedb.net/index.php?m=processor&id=423&c=apple_a7_apl0698_s5l8960x__alcatraz
        case .a8: "20 nm" // https://phonedb.net/index.php?m=processor&id=531&c=apple_a8_apl1011_t7000__fiji
        case .a8X: "20 nm" // https://phonedb.net/index.php?m=processor&id=548&c=apple_a8x_apl1012_t7001__capri
        case .a9: "14/16 nm" // https://phonedb.net/index.php?m=processor&id=626&c=apple_a9_apl0898_s8000__maui
        case .a9X: "16 nm" // https://phonedb.net/index.php?m=processor&id=629&c=apple_a9x_apl1021_s8001__elba
        case .a10Fusion: "16 nm" // https://phonedb.net/index.php?m=processor&id=677&c=apple_a10_fusion_apl1w24_t8010__cayman
        case .a10XFusion: "10 nm" // https://phonedb.net/index.php?m=processor&id=719&c=apple_a10x_fusion_apl1071_t8011__myst
        case .a11Bionic: "10 nm"
        case .a12Bionic: "7 nm (N7)"
        case .a12XBionic: "7 nm (N7)"
        case .a12ZBionic: "7 nm (N7)"
        case .a13Bionic: "7 nm (N7P)"
        case .a14Bionic: "5 nm (N5)"
        case .a15Bionic: "5 nm (N5P)"
        case .a16Bionic: "4 nm (N4P)"
        case .a17Pro: "3 nm (N3B)"
        case .a18: "3 nm (N3E)"
        case .a18Pro: "3 nm (N3E)"
        case .a19: "3 nm (N3P)"
        case .a19Pro: "3 nm (N3P)"
            
        case .m1: "5 nm (N5)"
        case .m2: "5 nm (N5P)"
        case .m3: "3 nm (N3)"
        case .m4: "3 nm (N3E)"
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
