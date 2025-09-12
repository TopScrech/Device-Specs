import DeviceKit

extension Device.CPU {
    var instructionSet: String {
        switch self {
#if os(iOS) || os(tvOS)
        case .a4: "ARMv7-A"
        case .a5: "ARMv7-A"
        case .a5X: "ARMv7-A"
        case .a6: "ARMv7-A \"Swift\""
        case .a6X: "ARMv7-A \"Swift\""
        case .a7: "ARMv8.0-A"
        case .a8: "ARMv8.0-A"
        case .a8X: "ARMv8.0-A"
        case .a9: "ARMv8.0-A"
        case .a9X: "ARMv8.0-A"
        case .a10Fusion: "ARMv8.1-A"
        case .a10XFusion: "ARMv8.1-A"
        case .a11Bionic: "ARMv8.2-A"
        case .a12Bionic: "ARMv8.3-A"
        case .a12XBionic: "ARMv8.3-A"
        case .a12ZBionic: "ARMv8.3-A"
        case .a13Bionic: "ARMv8.4-A"
        case .a14Bionic: "ARMv8.5-A"
        case .a15Bionic: "ARMv8.5-A"
        case .a16Bionic: "ARMv8.6-A"
        case .a17Pro: "ARMv8.6-A"
        case .a18: "ARMv9.2-A"
        case .a18Pro: "ARMv9.2-A"
        case .a19, .a19Pro: "ARMv9.2-A"
            
        case .m1: "ARMv8.4-A"
        case .m2: "ARMv8.6-A"
        case .m3: "ARMv8.6-A"
        case .m4: "ARMv9.2-A"
            
#elseif os(watchOS)
        case .s1: "ARMv7k"
        case .s1P: "ARMv7k"
        case .s2: "ARMv7k"
        case .s3: "ARMv7k"
        case .s4: "ARMv8-A (arm64_32)"
        case .s5: "ARMv8-A (arm64_32)"
        case .s6: "ARMv8-A (arm64_32)"
        case .s7: "ARMv8-A (arm64_32)"
        case .s8: "ARMv8-A (arm64_32)"
        case .s9: "ARMv8-A (arm64_32)"
        case .s10: "ARMv8-A (arm64_32)"
#endif
        case .unknown: "Unknown"
        @unknown default: "-"
        }
    }
}
