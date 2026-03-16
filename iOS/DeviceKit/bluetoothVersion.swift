import DeviceKit

// Sources:
// https://everymac.com/systems/apple/iphone/iphone-faq/iphone-bluetooth-support-by-model.html
// https://apple.com/iphone/compare

extension Device {
    var bluetoothVersion: String {
        switch self {
#if os(iOS)
        case .iPodTouch5: "4.0"
        case .iPodTouch6, .iPodTouch7: "4.1"
        case .iPhone4: "2.1 + EDR"
            
        case .iPhone4s,
                .iPhone5, .iPhone5c,
                .iPhone5s: "4.0"
            
        case .iPhoneSE, .iPhone6, .iPhone6Plus,
                .iPhone6s, .iPhone6sPlus,
                .iPhone7, .iPhone7Plus: "4.2"
            
        case .iPhone8, .iPhone8Plus,
                .iPhoneX,
                .iPhoneXS, .iPhoneXSMax,
                .iPhoneXR,
                .iPhone11, .iPhone11Pro, .iPhone11ProMax,
                .iPhoneSE2, .iPhoneSE3,
                .iPhone12, .iPhone12Mini, .iPhone12Pro, .iPhone12ProMax,
                .iPhone13, .iPhone13Mini, .iPhone13Pro, .iPhone13ProMax: "5.0"
            
        case .iPhone14, .iPhone14Plus, .iPhone14Pro, .iPhone14ProMax,
                .iPhone15, .iPhone15Plus, .iPhone15Pro, .iPhone15ProMax,
                .iPhone16, .iPhone16e, .iPhone16Plus, .iPhone16Pro, .iPhone16ProMax, .iPhone17e: "5.3"
            
        case .iPhone17, .iPhoneAir, .iPhone17Pro, .iPhone17ProMax: "6.0"
            
        case .iPad2: "2.1"
        case .iPad3, .iPad4: "4.0"
        case .iPad5, .iPad6, .iPad7, .iPad8, .iPad9: "4.2"
        case .iPad10: "5.2"
        case .iPadA16: "5.3"
            
        case .iPadAir: "4.0"
        case .iPadAir2: "4.2"
        case .iPadAir3, .iPadAir4, .iPadAir5, .iPadAir11M2, .iPadAir13M2: "5.0"
        case .iPadAir11M3, .iPadAir13M3: "5.3"
        case .iPadAir11M4, .iPadAir13M4: "6.0"
            
        case .iPadMini, .iPadMini2: "4.0"
        case .iPadMini3, .iPadMini4: "4.2"
        case .iPadMini5, .iPadMini6: "5.0"
        case .iPadMiniA17Pro: "5.3"
            
        case .iPadPro9Inch, .iPadPro12Inch,
                .iPadPro12Inch2, .iPadPro10Inch: "4.2"
            
        case .iPadPro11Inch, .iPadPro12Inch3,
                .iPadPro11Inch2, .iPadPro12Inch4,
                .iPadPro11Inch3, .iPadPro12Inch5: "5.0"
            
        case .iPadPro11Inch4, .iPadPro12Inch6,
                .iPadPro11M4, .iPadPro13M4: "5.3"
            
        case .iPadPro11M5, .iPadPro13M5: "6.0"
            
        case .homePod: "5.0" // HomePod 1, 2, mini
            
#elseif os(tvOS)
        case .appleTVHD: "5.0"
        case .appleTV4K: "4.0"
        case .appleTV4K2, .appleTV4K3: "5.0"
            
#elseif os(watchOS)
        case .appleWatchSeries0_38mm, .appleWatchSeries0_42mm,
                .appleWatchSeries1_38mm, .appleWatchSeries1_42mm,
                .appleWatchSeries2_38mm, .appleWatchSeries2_42mm: "4.0"
            
        case .appleWatchSeries3_38mm, .appleWatchSeries3_42mm: "4.2"
            
        case .appleWatchSeries4_40mm, .appleWatchSeries4_44mm,
                .appleWatchSeries5_40mm, .appleWatchSeries5_44mm,
                .appleWatchSeries6_40mm, .appleWatchSeries6_44mm,
                .appleWatchSE_40mm, .appleWatchSE_44mm,
                .appleWatchSeries7_41mm, .appleWatchSeries7_45mm: "5.0"
            
        case .appleWatchSeries8_41mm, .appleWatchSeries8_45mm,
                .appleWatchSE2_40mm, .appleWatchSE2_44mm,
                .appleWatchUltra,
                .appleWatchSeries9_41mm, .appleWatchSeries9_45mm,
                .appleWatchUltra2,
                .appleWatchSeries10_42mm, .appleWatchSeries10_46mm,
                .appleWatchUltra3,
                .appleWatchSeries11_42mm, .appleWatchSeries11_46mm: "5.3"
            //                .appleWatchSE3_40, .appleWatchSE3_44 confirmed 5.3
#endif
        case .simulator: "Simulator"
        case .unknown(let device): "Unknown (\(device))"
        @unknown default: "-"
        }
    }
}
