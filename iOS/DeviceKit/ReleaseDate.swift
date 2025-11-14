import DeviceKit

extension Device {
    var releaseDate: String {
        switch self {
#if os(iOS)
        case .iPodTouch5: "October 11, 2012"
        case .iPodTouch6: "July 15, 2015"
        case .iPodTouch7: "May 28, 2019"
        case .iPhone4: "June 24, 2010"
        case .iPhone4s: "October 14, 2011"
        case .iPhone5: "September 21, 2012"
        case .iPhone5c, .iPhone5s: "September 20, 2013"
        case .iPhone6, .iPhone6Plus: "September 19, 2014"
        case .iPhone6s, .iPhone6sPlus: "September 25, 2015"
        case .iPhoneSE: "March 31, 2016"
        case .iPhone7, .iPhone7Plus: "September 16, 2016"
        case .iPhone8, .iPhone8Plus: "September 22, 2017"
        case .iPhoneX: "November 3, 2017"
        case .iPhoneXS, .iPhoneXSMax: "September 21, 2018"
        case .iPhoneXR: "October 26, 2018"
        case .iPhone11, .iPhone11Pro, .iPhone11ProMax: "September 20, 2019"
        case .iPhoneSE2: "April 24, 2020"
        case .iPhone12, .iPhone12Pro, .iPhone12Mini, .iPhone12ProMax: "October 23, 2020"
        case .iPhone13, .iPhone13Mini, .iPhone13Pro, .iPhone13ProMax: "September 24, 2021"
        case .iPhoneSE3: "March 18, 2022"
        case .iPhone14, .iPhone14Plus, .iPhone14Pro, .iPhone14ProMax: "September 16, 2022"
        case .iPhone15, .iPhone15Plus, .iPhone15Pro, .iPhone15ProMax: "September 22, 2023"
        case .iPhone16, .iPhone16Plus, .iPhone16Pro, .iPhone16ProMax: "September 20, 2024"
        case .iPhone17, .iPhoneAir, .iPhone17Pro, .iPhone17ProMax: "September 9, 2025"
            
        case .iPad2: "March 11, 2011"
        case .iPad3: "March 16, 2012"
        case .iPad4, .iPadMini: "November 2, 2012"
        case .iPadAir: "November 1, 2013"
        case .iPadMini2: "October 23, 2013"
        case .iPadAir2, .iPadMini3: "October 22, 2014"
        case .iPadMini4: "September 9, 2015"
        case .iPadPro12Inch: "November 11, 2015"
        case .iPadPro9Inch: "March 31, 2016"
        case .iPad5: "March 24, 2017"
        case .iPadPro12Inch2, .iPadPro10Inch: "June 13, 2017"
        case .iPad6: "March 27, 2018"
        case .iPadPro11Inch, .iPadPro12Inch3: "November 7, 2018"
        case .iPadAir3, .iPadMini5: "March 18, 2019"
        case .iPad7: "September 25, 2019"
        case .iPadPro11Inch2, .iPadPro12Inch4: "March 25, 2020"
        case .iPad8: "September 18, 2020"
        case .iPadAir4: "October 23, 2020"
        case .iPadPro11Inch3, .iPadPro12Inch5: "May 21, 2021"
        case .iPad9, .iPadMini6: "September 24, 2021"
        case .iPadAir5: "March 18, 2022"
        case .iPad10, .iPadPro11Inch4, .iPadPro12Inch6: "October 26, 2022"
        case .iPadAir11M2, .iPadAir13M2, .iPadPro11M4, .iPadPro13M4: "May 15, 2024"
            
        case .homePod: "-"
            
#elseif os(tvOS)
        case .appleTVHD: "October 30, 2015"
        case .appleTV4K: "September 12, 2017"
        case .appleTV4K2: "May 21, 2021"
        case .appleTV4K3: "November 4, 2022"
            
#elseif os(watchOS)
        case .appleWatchSeries0_38mm, .appleWatchSeries0_42mm: "April 24, 2015"
        case .appleWatchSeries1_38mm, .appleWatchSeries1_42mm,
                .appleWatchSeries2_38mm, .appleWatchSeries2_42mm: "September 16, 2016"
        case .appleWatchSeries3_38mm, .appleWatchSeries3_42mm: "September 22, 2017"
        case .appleWatchSeries4_40mm, .appleWatchSeries4_44mm: "September 21, 2018"
        case .appleWatchSeries5_40mm, .appleWatchSeries5_44mm: "September 20, 2019"
        case .appleWatchSeries6_40mm, .appleWatchSeries6_44mm,
                .appleWatchSE_40mm, .appleWatchSE_44mm: "September 18, 2020"
        case .appleWatchSeries7_41mm, .appleWatchSeries7_45mm: "October 15, 2021"
        case .appleWatchSeries8_41mm, .appleWatchSeries8_45mm,
                .appleWatchSE2_40mm, .appleWatchSE2_44mm: "September 16, 2022"
        case .appleWatchUltra: "September 23, 2022"
        case .appleWatchSeries9_41mm, .appleWatchSeries9_45mm,
                .appleWatchUltra2: "September 22, 2023"
        case .appleWatchSeries10_42mm, .appleWatchSeries10_46mm: "September 20, 2024"
        case .appleWatchUltra3,
                .appleWatchSeries11_42mm, .appleWatchSeries11_46mm: "September 9, 2024"
            //                .appleWatchSE3_40mm, .appleWatchSE3_44mm confirmed September 9, 2024
#endif
        case .simulator: "N/a"
        case .unknown(let device): "Unknown device \(device.description)"
        default: "N/a"
        }
    }
}
