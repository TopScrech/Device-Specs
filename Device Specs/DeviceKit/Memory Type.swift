import DeviceKit

// Source: https://theapplewiki.com/wiki/Application_Processor

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
        case .a8: "LPDDR3-1600"
        case .a8X: "LPDDR3-1600"
        case .a9: "LPDDR4-3200"
        case .a9X: "LPDDR4-3200"
        case .a10Fusion: "LPDDR4-3200"
        case .a10XFusion: "LPDDR4-3200"
        case .a11Bionic: "LPDDR4X-4266"
        case .a12Bionic: "LPDDR4X-4266"
        case .a12XBionic: "LPDDR4X-4266"
        case .a12ZBionic: "LPDDR4X-4266"
        case .a13Bionic: "LPDDR4X-4266"
        case .a14Bionic: "LPDDR4X-4266"
        case .a15Bionic: "LPDDR4X-4266"
        case .a16Bionic: "LPDDR5-6400"
        case .a17Pro: "LPDDR5-6400"
        case .a18: "LPDDR5X-8533"
        case .a18Pro: "LPDDR5X-8533"
        case .a19Pro: "LPDDR5X"
            
        case .m1: "LPDDR4X-4266 2133 MHz (Pro, Max, Ultra - LPDDR4X-6400 (3200 MHz))"
        case .m2: "LPDDR5-6400"
        case .m3: "LPDDR5-6400"
        case .m4: "LPDDR5-7500" // Pro, Max, Ultra - ???
#elseif os(watchOS)
        case .s1: "LPDDR3"
        case .s1P: "LPDDR3"
        case .s2: "LPDDR3"
        case .s3: "LPDDR4"
        case .s4: "LPDDR4X (Probably)"
        case .s5: "LPDDR4X (Probably)"
        case .s6: "LPDDR4X (Probably)"
        case .s7: "LPDDR4X (Probably)"
        case .s8: "LPDDR4X (Probably)"
        case .s9: "LPDDR4X (Probably)"
        case .s10: "LPDDR4X (Probably)"
#endif
        case .unknown: "Unknown"
        @unknown default: "-"
        }
    }
}
