import DeviceKit

// Sources
// https://lowendmac.com
// https://apple.fandom.com

extension Device.CPU {
    var tops: String? {
        switch self {
#if os(iOS) || os(tvOS)
        case .a4, .a5, .a5X, .a6, .a6X, .a7, .a8, .a8X, .a9, .a9X, .a10Fusion, .a10XFusion: nil
            
        case .a11Bionic: "0.6"
        case .a12Bionic, .a12XBionic, .a12ZBionic: "5"
        case .a13Bionic: "6"
        case .a14Bionic: "11"
        case .a15Bionic: "15.8"
        case .a16Bionic: "17" // https://apple.fandom.com/wiki/Apple_A16
        case .a17Pro, .a18, .a18Pro: "35"
        case .a19: "35" // https://lowendmac.com/2025/apple-a19-specs
        case .a19Pro: "35" // https://lowendmac.com/2025/apple-a19-pro-specs
            
        case .m1: "11 (Ultra - 22)"
        case .m2: "15.8 (Ultra - 31.6)"
        case .m3: "18 (Ultra - 36)"
        case .m4: "38"
            
#elseif os(watchOS)
        case .s1, .s1P, .s2, .s3, .s4, .s5, .s6, .s7, .s8, .s9, .s10: "Unknown"
#endif
        case .unknown: "Unknown"
        @unknown default: "-"
        }
    }
    
    var neuralEngineCores: String? {
        switch self {
#if os(iOS) || os(tvOS)
        case .a4, .a5, .a5X, .a6, .a6X, .a7, .a8, .a8X, .a9, .a9X, .a10Fusion, .a10XFusion: nil
            
        case .a11Bionic: "2"
        case .a12Bionic, .a12XBionic,
                .a12ZBionic, .a13Bionic: "8"
        case .a14Bionic, .a15Bionic: "16"
        case .a16Bionic: "16" // https://apple.fandom.com/wiki/Apple_A16
        case .a17Pro, .a18, .a18Pro: "16"
            
        case .a19: "16" // https://lowendmac.com/2025/apple-a19-specs
        case .a19Pro: "16" // https://lowendmac.com/2025/apple-a19-pro-specs
            
        case .m1, .m2, .m3: "16 (Ultra - 32)"
        case .m4: "16"
        case .m5: "16"
            
#elseif os(watchOS)
        case .s1, .s1P, .s2, .s3, .s4, .s5, .s6, .s7, .s8: "Unknown"
        case .s9, .s10: "4"
#endif
        case .unknown: "Unknown"
        @unknown default: "-"
        }
    }
}
