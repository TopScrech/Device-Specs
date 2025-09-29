import DeviceKit

// Source: https://www.coolblue.nl/en/advice/which-iphones-are-waterproof.html

extension Device {
    var waterResistanceDescription: String {
        switch self {
#if os(iOS)
        case .iPhone7, .iPhone7Plus,
                .iPhone8, .iPhone8Plus,
                .iPhoneX,
                .iPhoneXR,
                .iPhoneSE2,
                .iPhoneSE3: "Up to 30 minutes and 1 meter deep"
            
        case .iPhoneXS, .iPhoneXSMax,
                .iPhone11: "Up to 30 minutes and 2 meters deep"
            
        case .iPhone11Pro, .iPhone11ProMax: "Up to 30 minutes and 4m deep"
            
        case .iPhone12, .iPhone12Mini, .iPhone12Pro, .iPhone12ProMax,
                .iPhone13, .iPhone13Mini, .iPhone13Pro, .iPhone13ProMax,
                .iPhone14, .iPhone14Plus, .iPhone14Pro, .iPhone14ProMax,
                .iPhone15, .iPhone15Plus, .iPhone15Pro, .iPhone15ProMax,
                .iPhone16, .iPhone16Plus, .iPhone16Pro, .iPhone16ProMax: "Up to 30 minutes and 6m deep"
            
#elseif os(watchOS)
        case .appleWatchSeries0_38mm, .appleWatchSeries0_42mm,
                .appleWatchSeries1_38mm, .appleWatchSeries1_42mm: "Splash and water resistant"
            
        case .appleWatchSeries2_38mm, .appleWatchSeries2_42mm,
                .appleWatchSeries3_38mm, .appleWatchSeries3_42mm,
                .appleWatchSeries4_40mm, .appleWatchSeries4_44mm,
                .appleWatchSeries5_40mm, .appleWatchSeries5_44mm,
                .appleWatchSeries6_40mm, .appleWatchSeries6_44mm,
                .appleWatchSE_40mm, .appleWatchSE_44mm,
                .appleWatchSE2_40mm, .appleWatchSE2_44mm: "Up to 50m deep"
            
        case .appleWatchSeries7_41mm, .appleWatchSeries7_45mm,
                .appleWatchSeries8_41mm, .appleWatchSeries8_45mm,
                .appleWatchSeries9_41mm, .appleWatchSeries9_45mm,
                .appleWatchSeries10_42mm, .appleWatchSeries10_46mm: "Up to 50m deep"
            
        case .appleWatchUltra, .appleWatchUltra2: "Up to 100m deep"
#endif
        case .simulator: "N/a"
        case .unknown(let device): "Unknown (\(device))"
        default: "-"
        }
    }
}
