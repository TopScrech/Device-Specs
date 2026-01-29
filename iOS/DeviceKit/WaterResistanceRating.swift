import DeviceKit

// Sources:
// https://coolblue.nl/en/advice/which-iphones-are-waterproof.html
// https://support.apple.com/en-gb/109522#:~:text=Apple%20Watch%20Series%202%20and,are%20rated%20IP6X%20dust%20resistant.
// https://support.apple.com/en-us/108039

extension Device {
    var waterResistance: String {
        switch self {
#if os(iOS)
        case .iPodTouch5, .iPodTouch6, .iPodTouch7: "None"
            
        case .iPhone4,
                .iPhone4s,
                .iPhone5,
                .iPhone5c,
                .iPhone5s,
                .iPhone6,
                .iPhone6Plus,
                .iPhone6s,
                .iPhone6sPlus,
                .iPhoneSE: "None"
            
        case .iPhone7, .iPhone7Plus,
                .iPhone8, .iPhone8Plus,
                .iPhoneX,
                .iPhoneXR,
                .iPhoneSE2,
                .iPhoneSE3: "IP67 (IEC 60529)"
            
        case .iPhoneXS, .iPhoneXSMax,
                .iPhone11: "IP68 (IEC 60529)"
            
        case .iPhone11Pro, .iPhone11ProMax: "IP68 (IEC 60529)"
            
        case .iPhone12, .iPhone12Mini, .iPhone12Pro, .iPhone12ProMax,
                .iPhone13, .iPhone13Mini, .iPhone13Pro, .iPhone13ProMax,
                .iPhone14, .iPhone14Plus, .iPhone14Pro, .iPhone14ProMax,
                .iPhone15, .iPhone15Plus, .iPhone15Pro, .iPhone15ProMax,
                .iPhone16, .iPhone16e, .iPhone16Plus, .iPhone16Pro, .iPhone16ProMax,
                .iPhone17, .iPhoneAir, .iPhone17Pro, .iPhone17ProMax: "IP68 (IEC 60529)"
            
        case .iPad2,
                .iPad3,
                .iPad4,
                .iPadAir,
                .iPadAir2,
                .iPad5,
                .iPad6,
                .iPadAir3,
                .iPad7,
                .iPad8,
                .iPad9,
                .iPad10,
                .iPadA16,
                .iPadAir4,
                .iPadAir5,
                .iPadAir11M2, .iPadAir13M2,
                .iPadAir11M3, .iPadAir13M3,
                .iPadMini,
                .iPadMini2,
                .iPadMini3,
                .iPadMini4,
                .iPadMini5,
                .iPadMini6,
                .iPadMiniA17Pro,
                .iPadPro9Inch,
                .iPadPro12Inch,
                .iPadPro12Inch2,
                .iPadPro10Inch,
                .iPadPro11Inch,
                .iPadPro12Inch3,
                .iPadPro11Inch2,
                .iPadPro12Inch4,
                .iPadPro11Inch3,
                .iPadPro12Inch5,
                .iPadPro11Inch4,
                .iPadPro12Inch6,
                .iPadPro11M4, .iPadPro13M4,
                .iPadPro11M5, .iPadPro13M5: "None"
            
        case .homePod: "None"
            
#elseif os(tvOS)
        case .appleTVHD, .appleTV4K, .appleTV4K2, .appleTV4K3: "None"
            
#elseif os(watchOS)
            
        case .appleWatchSeries0_38mm, .appleWatchSeries0_42mm,
                .appleWatchSeries1_38mm, .appleWatchSeries1_42mm: "IPX7 (IEC 60529)"
            
        case .appleWatchSeries2_38mm, .appleWatchSeries2_42mm,
                .appleWatchSeries3_38mm, .appleWatchSeries3_42mm,
                .appleWatchSeries4_40mm, .appleWatchSeries4_44mm,
                .appleWatchSeries5_40mm, .appleWatchSeries5_44mm,
                .appleWatchSeries6_40mm, .appleWatchSeries6_44mm,
                .appleWatchSE_40mm, .appleWatchSE_44mm,
                .appleWatchSE2_40mm, .appleWatchSE2_44mm: "ISO 22810:2010"
            //                .appleWatchSE3_40mm, appleWatchSE3_44mm confirmed ISO 22810:2010
            
        case .appleWatchSeries7_41mm, .appleWatchSeries7_45mm,
                .appleWatchSeries8_41mm, .appleWatchSeries8_45mm,
                .appleWatchSeries9_41mm, .appleWatchSeries9_45mm,
                .appleWatchSeries10_42mm, .appleWatchSeries10_46mm,
                .appleWatchSeries11_42mm, .appleWatchSeries11_46mm: "IP6X"
            
        case .appleWatchUltra, .appleWatchUltra2,  .appleWatchUltra3: "IP6X, ISO 22810:2010, EN13319"
#endif
        case .simulator: "N/a"
        case .unknown(let device): "Unknown (\(device))"
        @unknown default: "-"
        }
    }
}
