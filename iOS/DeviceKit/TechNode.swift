import DeviceKit

// Sources
// https://phonedb.net
// https://notebookcheck

extension Device.CPU {
    var techNode: String {
        switch self {
#if os(iOS) || os(tvOS)
        case .a4: "45 nm" // https://phonedb.net/index.php?m=processor&id=234&c=samsung-intrinsity_apple_a4_apl0398_s5l8930
            
            // https://phonedb.net/index.php?m=processor&id=282&c=apple_a5_apl0498_s5l8940
            // https://phonedb.net/index.php?m=processor&id=357&c=apple_a5r2_apl2498__s5l8942
            // https://phonedb.net/index.php?m=processor&id=968&c=apple_a5r3_apl7498__s5l8947
        case .a5: "45-32 nm"
            
        case .a5X: "45 nm" // https://phonedb.net/index.php?m=processor&id=335&c=apple_a5x_apl5498_s5l8945x
        case .a6: "32 nm" // https://phonedb.net/index.php?m=processor&id=356&c=apple_a6_apl0598_s5l8950x__bali
        case .a6X: "32 nm" // https://phonedb.net/index.php?m=processor&id=366&c=apple_a6x_apl5598_s5l8955x__bali
        
            // https://phonedb.net/index.php?m=processor&id=433&c=apple_a7_apl5698_s5l8965x__alcatraz
            // https://phonedb.net/index.php?m=processor&id=423&c=apple_a7_apl0698_s5l8960x__alcatraz
        case .a7: "28 nm"
        
        case .a8: "20 nm" // https://phonedb.net/index.php?m=processor&id=531&c=apple_a8_apl1011_t7000__fiji
        case .a8X: "20 nm" // https://phonedb.net/index.php?m=processor&id=548&c=apple_a8x_apl1012_t7001__capri
        case .a9: "14/16 nm" // https://phonedb.net/index.php?m=processor&id=626&c=apple_a9_apl0898_s8000__maui
        case .a9X: "16 nm" // https://phonedb.net/index.php?m=processor&id=629&c=apple_a9x_apl1021_s8001__elba
        case .a10Fusion: "16 nm" // https://phonedb.net/index.php?m=processor&id=677&c=apple_a10_fusion_apl1w24_t8010__cayman
        case .a10XFusion: "10 nm" // https://phonedb.net/index.php?m=processor&id=719&c=apple_a10x_fusion_apl1071_t8011__myst
        case .a11Bionic: "10 nm" // https://phonedb.net/index.php?m=processor&id=718&c=apple_a11_bionic_apl1w72_t8015__skye
        case .a12Bionic: "7 nm (N7)" // https://phonedb.net/index.php?m=processor&id=770&c=apple_a12_bionic_apl1w81_t8020__cyprus
        case .a12XBionic: "7 nm (N7)" // https://phonedb.net/index.php?m=processor&id=774&c=apple_a12x_bionic_apl1083_t8027__aruba
        case .a12ZBionic: "7 nm (N7)" // https://phonedb.net/index.php?m=processor&id=820&c=apple_a12z_bionic_apl1083_t8027__aruba#google_vignette
        case .a13Bionic: "7 nm (N7P)" // https://phonedb.net/index.php?m=processor&id=795&c=apple_a13_bionic_apl1w85_t8030__cebu
        case .a14Bionic: "5 nm (N5)" // https://phonedb.net/index.php?m=processor&id=835&c=apple_a14_bionic_apl1w01_t8101__sicily
            
            // https://phonedb.net/index.php?m=processor&id=898&c=apple_a15_bionic_lite_apl1w07_t8110__ellis
            // https://phonedb.net/index.php?m=processor&id=871&c=apple_a15_bionic_apl1w07_t8110__ellis
        case .a15Bionic: "5 nm (N5P)"
            
            // https://phonedb.net/index.php?m=processor&id=1020&c=apple_a16_bionic_lite_apl1010__apl1w10
            // https://phonedb.net/index.php?m=processor&id=903&c=apple_a16_bionic_apl1w10_t8120__crete
        case .a16Bionic: "4 nm (N4P)"
            
        case .a17Pro: "3 nm (N3B)" // https://phonedb.net/index.php?m=processor&id=944&c=apple_a17_pro_apl1v02_t8130__coll#google_vignette
            
            // https://phonedb.net/index.php?m=processor&id=992&c=apple_a18_apl1v08_t8142__tupai
            // https://notebookcheck.net/Apple-A18-Processor-Benchmarks-and-Specs.891555.0.html
        case .a18: "3 nm (N3E)"
            
        case .a18Pro: "3 nm (N3E)" // https://phonedb.net/index.php?m=processor&id=991&c=apple_a18_pro_apl1v07_t8140__tahiti
        case .a19: "3 nm (N3P)"
        case .a19Pro: "3 nm (N3P)"
            
        case .m1: "5 nm (N5)"
        case .m2: "5 nm (N5P)"
        case .m3: "3 nm (N3)"
        case .m4: "3 nm (N3E)"
#elseif os(watchOS)
        case .s1: "28 nm" // https://phonedb.net/index.php?m=processor&id=599&c=apple_s1_apl0778_s7002
            
            // Apple APL0778 is 28 nm: https://www.iclarified.com/49012/the-apple-watch-s1-sip-has-over-30-individual-components-image
            // 28: https://en.wikipedia.org/wiki/Apple_S1
            // 16: https://check-mac.com/en/cpu-apple_s1p
        case .s1P: "28 nm"
            
        case .s2: "16 nm" // https://en.wikipedia.org/wiki/Apple_S2
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
