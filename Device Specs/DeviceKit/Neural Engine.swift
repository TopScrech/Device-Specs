import DeviceKit

extension Device.CPU {
    var tops: String? {
        switch self {
#if os(iOS) || os(tvOS)
        case .a4, .a5, .a5X, .a6, .a6X, .a7, .a8, .a8X, .a9, .a9X, .a10Fusion, .a10XFusion: nil
            
        case .a11Bionic: "0.6"
        case .a12Bionic: "5"
        case .a12XBionic: "5"
        case .a12ZBionic: "5"
        case .a13Bionic: "6"
        case .a14Bionic: "11"
        case .a15Bionic: "15.8"
        case .a16Bionic: "17"
        case .a17Pro: "35"
        case .a18: "35"
        case .a18Pro: "35"
            
        case .m1: "11 (Ultra - 22)"
        case .m2: "15.8 (Ultra - 31.6)"
        case .m3: "18"
        case .m4: "38"
            
#elseif os(watchOS)
        case .s1, .s1P, .s2, .s3, .s4, .s5, .s6, .s7, .s8, .s9, .s10: "Unknown"
#endif
        case .unknown: "Unknown"
        }
    }
    
    var neuralEngineCores: String? {
        switch self {
#if os(iOS) || os(tvOS)
        case .a4, .a5, .a5X, .a6, .a6X, .a7, .a8, .a8X, .a9, .a9X, .a10Fusion, .a10XFusion: nil
            
        case .a11Bionic: "2"
        case .a12Bionic: "8"
        case .a12XBionic: "8"
        case .a12ZBionic: "8"
        case .a13Bionic: "8"
        case .a14Bionic: "16"
        case .a15Bionic: "16"
        case .a16Bionic: "16"
        case .a17Pro: "16"
        case .a18: "16"
        case .a18Pro: "16"
            
        case .m1: "16 (Ultra - 32)"
        case .m2: "16 (Ultra - 32)"
        case .m3: "16"
        case .m4: "16 (Ultra - 32)"
            
#elseif os(watchOS)
        case .s1, .s1P, .s2, .s3, .s4, .s5, .s6, .s7, .s8, .s10: "Unknown"
        case .s9: "4"
#endif
        case .unknown: "Unknown"
        }
    }
}
