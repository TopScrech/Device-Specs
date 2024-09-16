import SwiftUI

@Observable
final class BatteryVM {
    var batteryLevel = ""
    var batteryState = ""
    var lowPowerMode = ""
    
    func fetchBatteryInfo() {
#if os(watchOS)
        let device = WKInterfaceDevice.current()
        
        device.isBatteryMonitoringEnabled = true
        
        let batteryLevelNumber = String(format: "%.0f", device.batteryLevel * 100)
        
        lowPowerMode = ProcessInfo.processInfo.isLowPowerModeEnabled ? "Yes" : "No"
        
        let batteryStateEnum = device.batteryState
#else
        let device = UIDevice.current
        
        device.isBatteryMonitoringEnabled = true
        
        let batteryLevelNumber = String(format: "%.0f", device.batteryLevel * 100)
        
        lowPowerMode = ProcessInfo.processInfo.isLowPowerModeEnabled ? "Yes" : "No"
        
        let batteryStateEnum = device.batteryState
#endif
        batteryLevel = batteryLevelNumber + "%"
        
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
