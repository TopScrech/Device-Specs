import SwiftUI

@Observable
final class BatteryVM {
    var batteryLevel = ""
    var batteryState = ""
    var lowPowerMode = ""
    
    //    init() {
    //        NotificationCenter.default.addObserver(self, selector: #selector(batteryLevelDidChange), name: .UIDeviceBatteryLevelDidChange, object: nil)
    //    }
    //
    //    func batteryLevelDidChange(_ notification: Notification) {
    //        print(batteryLevel)
    //    }
    
    func fetchBatteryInfo() {
        UIDevice.current.isBatteryMonitoringEnabled = true
        
        let batteryLevelNumber = String(format: "%.0f", UIDevice.current.batteryLevel * 100)
        batteryLevel = batteryLevelNumber + "%"
        
        lowPowerMode = ProcessInfo.processInfo.isLowPowerModeEnabled ? "Yes" : "No"
        
        let batteryStateEnum = UIDevice.current.batteryState
        
        switch batteryStateEnum {
        case .unknown:
            batteryState = "Unknown"
            
        case .unplugged:
            batteryState = "Unplugged"
            
        case .charging:
            batteryState = "Charging"
            
        case .full:
            batteryState = "Full"
            
        @unknown default:
            batteryState = "Unknown"
        }
    }
}
