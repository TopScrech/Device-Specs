import DeviceKit

// Sources
// https://gsmarena.com
// https://app.clickdimensions.com/blob/chemtreccom-ajrb1/files/apis_bpisreportupdated20220909.pdf?1662765043983
// https://macworld.com/article/678413/iphone-battery-capacities-compared-all-iphones-battery-life-in-mah-and-wh.html

// MagSafe battery pack: 1460mAh (11.13 Wh)

extension Device {
    var batteryCapacity: String {
        switch self {
#if os(iOS)
        case .iPodTouch5: "1030 mAh (3.8 Wh)"
        case .iPodTouch6: "1043 mAh (3.99 Wh)"
        case .iPodTouch7: "1043 mAh (3.99 Wh)"
        case .iPhone4: "1420 mAh (0.525 Wh)" // https://gsmarena.com/apple_iphone_4-3275.php
        case .iPhone4s: "1432 mAh (5.291 Wh)" // https://gsmarena.com/apple_iphone_4s-4212.php
        case .iPhone5: "1440 mAh (5.45 Wh)" // https://gsmarena.com/apple_iphone_5-4910.php
        case .iPhone5c: "1508 mAh (5.73 Wh)"
        case .iPhone5s: "1508 mAh (5.92 Wh)"
        case .iPhone6: "1809 mAh (6.91 Wh)"
        case .iPhone6Plus: "2906 mAh (10.45 Wh)"
        case .iPhone6s: "1715 mAh (6.55 Wh)"
        case .iPhone6sPlus: "2750 mAh (10.45 Wh)"
        case .iPhoneSE: "1624 mAh (6.21 Wh)"
        case .iPhone7: "1960 mAh (7.45 Wh)"
        case .iPhone7Plus: "2900 mAh (11.1 Wh)"
        case .iPhone8: "1821 mAh (6.96 Wh)"
        case .iPhone8Plus: "2691 mAh (10.28 Wh)"
        case .iPhoneSE2: "1821 mAh (6.96 Wh)"
        case .iPhoneX: "2716 mAh (10.35 Wh)"
        case .iPhoneXS: "2658 mAh (10.13 Wh)"
        case .iPhoneXSMax: "3174 mAh (12.08 Wh)"
        case .iPhoneXR: "2942 mAh (11.16 Wh)"
        case .iPhone11: "3110 mAh (11.91 Wh)"
        case .iPhone11Pro: "3046 mAh (11.67 Wh)"
        case .iPhone11ProMax: "3969 mAh (15.04 Wh)"
        case .iPhone12Mini: "2227 mAh (8.57 Wh)"
        case .iPhone12: "2815 mAh (10.78 Wh)"
        case .iPhone12Pro: "2815 mAh (10.78 Wh)"
        case .iPhone12ProMax: "3687 mAh (14.13 Wh)"
        case .iPhone13Mini: "2406 mAh (9.34 Wh)"
        case .iPhone13: "3227 mAh (12.41 Wh)"
        case .iPhone13Pro: "3095 mAh (11.97 Wh)"
        case .iPhone13ProMax: "4352 mAh (16.75 Wh)"
        case .iPhoneSE3: "2018 mAh (7.82 Wh)"
        case .iPhone14: "3279 mAh (12.68 Wh)"
        case .iPhone14Plus: "4325 mAh (16.68 Wh)"
        case .iPhone14Pro: "3200 mAh (12.38 Wh)"
        case .iPhone14ProMax: "4323 mAh (16.68 Wh)"
        case .iPhone15: "3349 mAh (12.98 Wh)"
        case .iPhone15Plus: "4383 mAh (16.95 Wh)"
        case .iPhone15Pro: "3274 mAh (12.7 Wh)"
        case .iPhone15ProMax: "4422 mAh (17.11 Wh)"
        case .iPhone16: "3561 mAh (13.7 Wh)"
        case .iPhone16e: "4005 mAh" // https://gsmarena.com/apple_iphone_16e-13395.php
        case .iPhone16Pro: "3582 mAh (13.8 Wh)"
        case .iPhone16Plus: "4674 mAh (18 Wh)"
        case .iPhone16ProMax: "4685 mAh (18 Wh)" // https://gsmarena.com/apple_iphone_16_pro_max-13123.php
        case .iPhone17: "3692 mAh" // https://gsmarena.com/apple_iphone_17-14050.php
        case .iPhone17Pro: "3998 mAh (eSIM-only: 4252 mAh)" // https://gsmarena.com/apple_iphone_17_pro-14049.php
        case .iPhone17ProMax: "4832 mAh (eSIM-only: 5088 mAh)" // https://gsmarena.com/apple_iphone_17_pro_max-13964.php
        case .iPhoneAir: "3149 mAh" // https://gsmarena.com/apple_iphone_17_air-13502.php
            
        case .iPad2: "6930 mAh (25 Wh)"
        case .iPad3: "11560 mAh (42.5 Wh)"
        case .iPad4: "11560 mAh (42.5 Wh)"
        case .iPad5: "8820 mAh (32.9 Wh)"
        case .iPad6: "8820 mAh (32.9 Wh)"
        case .iPad7: "8820 mAh (32.9 Wh)"
        case .iPad8: "8827 mAh (32.4 Wh)"
        case .iPad9: "8557 mAh (32.4 Wh)" // https://gsmarena.com/apple_ipad_10_2_(2021)-11106.php
        case .iPad10: "7606 mAh (28.6 Wh)" // https://gsmarena.com/apple_ipad_(2022)-11941.php
        case .iPadA16: "28.93 Wh" // https://gsmarena.com/apple_ipad_(2025)-13702.php
            
        case .iPadAir: "8820 mAh (32.9 Wh)"
        case .iPadAir2: "7340 mAh (27.62 Wh)"
        case .iPadAir3: "8134 mAh (30.8 Wh)"
        case .iPadAir4: "7606 mAh (28.6 Wh)" // https://gsmarena.com/apple_ipad_air_(2020)-10444.php
        case .iPadAir5: "7600 mAh (28.6 Wh)" // https://gsmarena.com/apple_ipad_air_(2022)-11411.php
        case .iPadAir11M2: "7606 mAh (28.93 Wh)" // https://gsmarena.com/apple_ipad_air_11_(2024)-12984.php
        case .iPadAir13M2: "9705 mAh (36.59 Wh)" // https://gsmarena.com/apple_ipad_air_13_(2024)-12985.php
        case .iPadAir11M3: "7606 mAh (28.93 Wh)" // https://gsmarena.com/apple_ipad_air_11_(2025)-13703.php
        case .iPadAir13M3: "9705 mAh (36.59 Wh)" // https://gsmarena.com/apple_ipad_air_13_(2025)-13704.php
            
        case .iPadMini: "4440 mAh (16.5 Wh)"
        case .iPadMini2, .iPadMini3: "6471 mAh (24.3 Wh)"
        case .iPadMini4, .iPadMini5: "5124 mAh (19.1 Wh)"
        case .iPadMini6: "5124 mAh (19.3 Wh)"
        case .iPadMiniA17Pro: "5078 mAh (19.3 Wh)" // https://gsmarena.com/apple_ipad_mini_(2024)-13437.php
            
        case .iPadPro9Inch: "7306mAh (27.91 Wh)"
        case .iPadPro12Inch: "10307mAh (38.8 Wh)"
        case .iPadPro12Inch2: "10994mAh (41.4 Wh)"
        case .iPadPro10Inch: "8134mAh (30.8 Wh)"
        case .iPadPro11Inch: "7812mAh (29.45 Wh)"
        case .iPadPro12Inch3: "9720mAh (36.71 Wh)"
        case .iPadPro11Inch2: "7540mAh (28.79 Wh)"
        case .iPadPro12Inch4: "9720mAh (36.71 Wh)"
        case .iPadPro11Inch3: "7538 mAh (28.65 Wh)"
        case .iPadPro12Inch5: "10566 mAh (40.33 Wh)"
        case .iPadPro11Inch4: "7538 mAh (28.65 Wh)"
        case .iPadPro12Inch6: "10758 mAh (40.88 Wh)"
        case .iPadPro11M4: "8160 mAh (31.29 Wh)" // https://gsmarena.com/apple_ipad_pro_11_(2024)-12986.php
        case .iPadPro13M4: "10290 mAh (38.99 Wh)" // https://gsmarena.com/apple_ipad_pro_13_(2024)-12987.php
            
        case .homePod: "N/a"
            
#elseif os(tvOS)
        case .appleTVHD: "N/a"
        case .appleTV4K: "N/a"
        case .appleTV4K2: "N/a"
        case .appleTV4K3: "N/a"
            
#elseif os(watchOS)
        case .appleWatchSeries0_38mm: "205 mAh (0.78 Wh)"
        case .appleWatchSeries0_42mm: "246 mAh (0.93 Wh)"
        case .appleWatchSeries1_38mm: "205 mAh (0.78 Wh)"
        case .appleWatchSeries1_42mm: "246 mAh (0.93 Wh)"
        case .appleWatchSeries2_38mm: "273 mAh (1.03 Wh)"
        case .appleWatchSeries2_42mm: "334 mAh (1.27 Wh)"
        case .appleWatchSeries3_38mm: "262 mAh (1 Wh), Cellular: 279 mAh (1.07 Wh)"
        case .appleWatchSeries3_42mm: "342 mAh (1.31 Wh), Cellular: 352 mAh (1.34 Wh)"
        case .appleWatchSeries4_40mm: "224.9 mAh (0.858 Wh)"
        case .appleWatchSeries4_44mm: "291.8 mAh (1.113 Wh)"
        case .appleWatchSeries5_40mm: "245 mAh (0.944 Wh)"
        case .appleWatchSeries5_44mm: "296 mAh (1.129 Wh)"
        case .appleWatchSeries6_40mm: "265.9 mAh (1.024 Wh)"
        case .appleWatchSeries6_44mm: "303.8 mAh (1.17 Wh)"
        case .appleWatchSE_40mm: "254 mAh (0.944 Wh)"
        case .appleWatchSE_44mm: "296 mAh (1.129 Wh)"
        case .appleWatchSeries7_41mm: "284 mAh (1.094 Wh)"
        case .appleWatchSeries7_45mm: "309 mAh (1.189 Wh)"
        case .appleWatchSeries8_41mm: "282 mAh" // https://www.macrumors.com/2023/09/15/apple-watch-series-9-ultra-2-battery-capacities/
        case .appleWatchSeries8_45mm: "308 mAh" // https://www.macrumors.com/2023/09/15/apple-watch-series-9-ultra-2-battery-capacities/
        case .appleWatchSE2_40mm: "245 mAh"
        case .appleWatchSE2_44mm: "296 mAh"
        case .appleWatchUltra: "542 mAh" // https://www.macrumors.com/2023/09/15/apple-watch-series-9-ultra-2-battery-capacities/
        case .appleWatchSeries9_41mm: "282 mAh" // https://www.macrumors.com/2023/09/15/apple-watch-series-9-ultra-2-battery-capacities/
        case .appleWatchSeries9_45mm: "308 mAh" // https://www.macrumors.com/2023/09/15/apple-watch-series-9-ultra-2-battery-capacities/
        case .appleWatchUltra2: "564 mAh" // https://www.macrumors.com/2023/09/15/apple-watch-series-9-ultra-2-battery-capacities/
        case .appleWatchSeries10_42mm: "-"
        case .appleWatchSeries10_46mm: "327 mAh" // https://www.gsmarena.com/apple_watch_series_10-13318.php
#endif
        case .simulator: "-"
        case .unknown(let device): "Unknown device \(device.description)"
        @unknown default: "N/a"
        }
    }
}
