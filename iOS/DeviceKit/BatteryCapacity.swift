import DeviceKit

// Sources
// https://gsmarena.com

extension Device {
    var batteryCapacity: String {
        switch self {
#if os(iOS)
        case .iPodTouch5: "1030 mAh"
        case .iPodTouch6: "1043 mAh"
        case .iPodTouch7: "1043 mAh"
        case .iPhone4: "1420 mAh" // https://gsmarena.com/apple_iphone_4-3275.php
        case .iPhone4s: "1432 mAh" // https://gsmarena.com/apple_iphone_4s-4212.php
        case .iPhone5: "1440 mAh" // https://gsmarena.com/apple_iphone_5-4910.php
        case .iPhone5c, .iPhone5s: "1508 mAh"
        case .iPhone6: "1809 mAh"
        case .iPhone6Plus: "2906 mAh"
        case .iPhone6s: "1715 mAh"
        case .iPhone6sPlus: "2750 mAh"
        case .iPhoneSE: "1624 mAh"
        case .iPhone7: "1960 mAh"
        case .iPhone7Plus: "2900 mAh"
        case .iPhone8, .iPhoneSE2: "1821 mAh"
        case .iPhone8Plus: "2691 mAh"
        case .iPhoneX: "2716 mAh"
        case .iPhoneXR: "2942 mAh"
        case .iPhoneXS: "2658 mAh"
        case .iPhoneXSMax: "3174 mAh"
        case .iPhone11: "3110 mAh"
        case .iPhone11Pro: "3046 mAh"
        case .iPhone11ProMax: "3969 mAh"
        case .iPhone12Mini: "2227 mAh"
        case .iPhone12, .iPhone12Pro: "2815 mAh"
        case .iPhone12ProMax: "3687 mAh"
        case .iPhone13Mini: "2406 mAh"
        case .iPhone13: "3227 mAh"
        case .iPhone13Pro: "3095 mAh"
        case .iPhone13ProMax: "4352 mAh"
        case .iPhoneSE3: "2018 mAh"
        case .iPhone14: "3279 mAh"
        case .iPhone14Plus: "4325 mAh"
        case .iPhone14Pro: "3200 mAh"
        case .iPhone14ProMax: "4323 mAh"
        case .iPhone15: "3349 mAh"
        case .iPhone15Plus: "4383 mAh"
        case .iPhone15Pro: "3274 mAh"
        case .iPhone15ProMax: "4422 mAh"
        case .iPhone16: "3561 mAh"
        case .iPhone16e: "4005 mAh" // https://gsmarena.com/apple_iphone_16e-13395.php
        case .iPhone16Pro: "3582 mAh"
        case .iPhone16Plus: "4674 mAh"
        case .iPhone16ProMax: "4685 mAh" // https://gsmarena.com/apple_iphone_16_pro_max-13123.php
            
        case .iPhone17: "3692 mAh" // https://gsmarena.com/apple_iphone_17-14050.php
            
        case .iPhone17Pro: "3998 mAh (eSIM-only: 4252 mAh)" // https://gsmarena.com/apple_iphone_17_pro-14049.php
            
            // https://gsmarena.com/apple_iphone_17_pro_max-13964.php
        case .iPhone17ProMax: "4832 mAh (eSIM-only: 5088 mAh)"
            
        case .iPad2: "6930 mAh"
        case .iPad3: "11560 mAh"
        case .iPad4: "11560 mAh"
        case .iPad5, .iPad6, .iPad7: "8820 mAh"
        case .iPad8: "8827 mAh"
        case .iPad9: "8557 mAh (32.4 Wh)" // https://gsmarena.com/apple_ipad_10_2_(2021)-11106.php
        case .iPad10: "7606 mAh (28.6 Wh)" // https://gsmarena.com/apple_ipad_(2022)-11941.php
        case .iPadA16: "28.93 Wh" // https://gsmarena.com/apple_ipad_(2025)-13702.php
            
        case .iPhoneAir: "3149 mAh" // https://gsmarena.com/apple_iphone_17_air-13502.php
        case .iPadAir: "8820 mAh"
        case .iPadAir2: "7340 mAh"
        case .iPadAir3: "8134 mAh"
        case .iPadAir4: "7606 mAh (28.93 Wh)" // https://gsmarena.com/apple_ipad_air_(2020)-10444.php
        case .iPadAir5: "7600 mAh (28.6 Wh)" // https://gsmarena.com/apple_ipad_air_(2022)-11411.php
        case .iPadAir11M2: "7606 mAh (28.93 Wh)" // https://gsmarena.com/apple_ipad_air_11_(2024)-12984.php
        case .iPadAir13M2: "9705 mAh (36.59 Wh)" // https://gsmarena.com/apple_ipad_air_13_(2024)-12985.php
        case .iPadAir11M3: "7606 mAh (28.93 Wh)" // https://gsmarena.com/apple_ipad_air_11_(2025)-13703.php
        case .iPadAir13M3: "9705 mAh (36.59 Wh)" // https://gsmarena.com/apple_ipad_air_13_(2025)-13704.php
            
        case .iPadMini: "4440 mAh"
        case .iPadMini2, .iPadMini3: "6471 mAh"
        case .iPadMini4, .iPadMini5, .iPadMini6: "5124 mAh"
        case .iPadMiniA17Pro: "5078 mAh (19.3 Wh)" // https://www.gsmarena.com/apple_ipad_mini_(2024)-13437.php
            
        case .iPadPro9Inch: "7,306mAh"
        case .iPadPro12Inch: "10307mAh"
        case .iPadPro12Inch2: "10994mAh"
        case .iPadPro10Inch: "8134mAh"
        case .iPadPro11Inch: "7812mAh"
        case .iPadPro12Inch3: "9720mAh"
        case .iPadPro11Inch2: "7540mAh"
        case .iPadPro12Inch4: "9720mAh"
        case .iPadPro11Inch3: "7538 mAh"
        case .iPadPro12Inch5: "10566 mAh"
        case .iPadPro11Inch4: "7538 mAh"
        case .iPadPro12Inch6: "10758 mAh"
        case .iPadPro11M4: "8160 mAh" // https://gsmarena.com/apple_ipad_pro_11_(2024)-12986.php
        case .iPadPro13M4: "10290 mAh" // https://gsmarena.com/apple_ipad_pro_13_(2024)-12987.php
            
        case .homePod: "N/a"
            
#elseif os(tvOS)
        case .appleTVHD: "N/a"
        case .appleTV4K: "N/a"
        case .appleTV4K2: "N/a"
        case .appleTV4K3: "N/a"
            
#elseif os(watchOS)
        case .appleWatchSeries0_38mm: "205 mAh"
        case .appleWatchSeries0_42mm: "246 mAh"
        case .appleWatchSeries1_38mm: "205 mAh"
        case .appleWatchSeries1_42mm: "246 mAh"
        case .appleWatchSeries2_38mm: "273 mAh"
        case .appleWatchSeries2_42mm: "334 mAh"
        case .appleWatchSeries3_38mm: "262 mAh (Cellular - 279 mAh)"
        case .appleWatchSeries3_42mm: "342 mAh (Cellular - 352 mAh"
        case .appleWatchSeries4_40mm: "224.9 mAh"
        case .appleWatchSeries4_44mm: "291.8 mAh"
        case .appleWatchSeries5_40mm: "245 mAh"
        case .appleWatchSeries5_44mm: "296 mAh"
        case .appleWatchSeries6_40mm: "265.9 mAh"
        case .appleWatchSeries6_44mm: "303.8 mAh"
        case .appleWatchSE_40mm: "254 mAh"
        case .appleWatchSE_44mm: "296 mAh"
        case .appleWatchSeries7_41mm: "284 mAh"
        case .appleWatchSeries7_45mm: "309 mAh"
        case .appleWatchSeries8_41mm: "282 mAh"
        case .appleWatchSeries8_45mm: "308 mAh"
        case .appleWatchSE2_40mm: "245 mAh"
        case .appleWatchSE2_44mm: "296 mAh"
        case .appleWatchUltra: "542 mAh"
        case .appleWatchSeries9_41mm: "282 mAh"
        case .appleWatchSeries9_45mm: "-"
        case .appleWatchUltra2: "564 mAh"
        case .appleWatchSeries10_42mm: "-"
        case .appleWatchSeries10_46mm: "-"
#endif
        case .simulator: "-"
        case .unknown(let device): "Unknown device \(device.description)"
        @unknown default: "N/a"
        }
    }
}

//import DeviceKit
//
//// MagSafe battery pack: 1460mAh / 11.13W
//
//// Sources:
//// https://app.clickdimensions.com/blob/chemtreccom-ajrb1/files/apis_bpisreportupdated20220909.pdf?1662765043983
//// https://macworld.com/article/678413/iphone-battery-capacities-compared-all-iphones-battery-life-in-mah-and-wh.html
//
//extension Device {
//    var power: String {
//        switch self {
//#if os(iOS)
//        case .iPodTouch5: "3.8 Wh"
//        case .iPodTouch6, .iPodTouch7: "3.99 Wh"
//        case .iPhone4: "0.525 Wh"
//        case .iPhone4s: "5.291 Wh"
//        case .iPhone5: "5.45 Wh"
//        case .iPhone5c: "5.73 Wh"
//        case .iPhone5s: "5.92 Wh"
//        case .iPhone6: "6.91 Wh"
//        case .iPhone6Plus: "10.45 Wh"
//        case .iPhone6s: "6.55 Wh"
//        case .iPhone6sPlus: "10.45 Wh"
//        case .iPhone7: "7.45 Wh"
//        case .iPhone7Plus: "11.1 Wh"
//        case .iPhoneSE: "6.21 Wh"
//        case .iPhone8: "6.96 Wh"
//        case .iPhone8Plus: "10.28 Wh"
//        case .iPhoneX: "10.35 Wh"
//        case .iPhoneXS: "10.13 Wh"
//        case .iPhoneXSMax: "12.08 Wh"
//        case .iPhoneXR: "11.16 Wh"
//        case .iPhone11: "11.91 Wh"
//        case .iPhone11Pro: "11.67 Wh"
//        case .iPhone11ProMax: "15.04 Wh"
//        case .iPhoneSE2: "6.96 Wh"
//        case .iPhone12: "10.78 Wh"
//        case .iPhone12Mini: "8.57 Wh"
//        case .iPhone12Pro: "10.78 Wh"
//        case .iPhone12ProMax: "14.13 Wh"
//        case .iPhone13: "12.41 Wh"
//        case .iPhone13Mini: "9.34 Wh"
//        case .iPhone13Pro: "11.97 Wh"
//        case .iPhone13ProMax: "16.75 Wh"
//        case .iPhoneSE3: "7.82 Wh"
//        case .iPhone14: "12.68 Wh"
//        case .iPhone14Pro: "12.38 Wh"
//        case .iPhone14Plus, .iPhone14ProMax: "16.68 Wh"
//        case .iPhone15: "12.98 Wh"
//        case .iPhone15Plus: "16.95 Wh"
//        case .iPhone15Pro: "12.7 Wh"
//        case .iPhone15ProMax: "17.11 Wh"
//        case .iPhone16: "13.7 Wh"
//        case .iPhone16Plus: "18 Wh"
//        case .iPhone16Pro: "13.8 Wh"
//        case .iPhone16ProMax: "18 Wh"
//        case .iPad2: "25 Wh"
//        case .iPad3, .iPad4: "42.5 Wh"
//        case .iPadAir: "32.9 Wh"
//        case .iPadAir2: "27.62 Wh"
//        case .iPad5, .iPad6, .iPad7: "32.9 Wh"
//        case .iPadAir3: "30.8 Wh"
//        case .iPad8, .iPad9: "32.4 Wh"
//        case .iPad10: "28.6 Wh"
//        case .iPadAir4, .iPadAir5: "28.6 Wh"
//        case .iPadAir11M2: "28.93 Wh"
//        case .iPadAir13M2: "36.59 Wh"
//        case .iPadMini: "16.5 Wh"
//        case .iPadMini2, .iPadMini3: "24.3 Wh"
//        case .iPadMini4, .iPadMini5: "19.1 Wh"
//        case .iPadMini6: "19.3 Wh"
//        case .iPadPro9Inch: "27.91 Wh"
//        case .iPadPro12Inch: "38.8 Wh"
//        case .iPadPro12Inch2: "41.4 Wh"
//        case .iPadPro10Inch: "30.8 Wh"
//        case .iPadPro11Inch: "29.45 Wh"
//        case .iPadPro12Inch3: "36.71 Wh"
//        case .iPadPro11Inch2: "28.79 Wh"
//        case .iPadPro12Inch4: "36.71 Wh"
//        case .iPadPro11Inch3: "28.65 Wh"
//        case .iPadPro12Inch5: "40.33 Wh"
//        case .iPadPro11Inch4: "28.65 Wh"
//        case .iPadPro12Inch6: "40.88 Wh"
//        case .iPadPro11M4: "31.29 Wh"
//        case .iPadPro13M4: "38.99 Wh"
//#elseif os(tvOS)
//        case .appleTVHD: "410 Wh"
//#elseif os(watchOS)
//        case .appleWatchSeries0_38mm, .appleWatchSeries1_38mm: "0.78 Wh"
//        case .appleWatchSeries0_42mm, .appleWatchSeries1_42mm: "0.93 Wh"
//        case .appleWatchSeries2_38mm: "1.03 Wh"
//        case .appleWatchSeries2_42mm: "1.27 Wh"
//        case .appleWatchSeries3_38mm: "1 Wh (Cellular - 1.07 Wh)"
//        case .appleWatchSeries3_42mm: "1.31 Wh (Cellular - 1.34 Wh)"
//        case .appleWatchSeries4_40mm: "0.858 Wh"
//        case .appleWatchSeries4_44mm: "1.113 Wh"
//        case .appleWatchSeries5_40mm, .appleWatchSE_40mm: "0.944 Wh"
//        case .appleWatchSeries5_44mm, .appleWatchSE_44mm: "1.129 Wh"
//        case .appleWatchSeries6_40mm: "1.024 Wh"
//        case .appleWatchSeries6_44mm: "1.17 Wh"
//        case .appleWatchSeries7_41mm: "1.094 Wh"
//        case .appleWatchSeries7_45mm: "1.189 Wh"
//#endif
//        case .unknown(let device): "Unknown device \(device.description)"
//        @unknown default: "-"
//        }
//    }
//}
