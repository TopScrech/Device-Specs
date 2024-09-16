import SwiftUI

@Observable
final class BatteryVM {
    var batteryLevel = ""
    var batteryState = ""
    var lowPowerMode = ""
    
    init() {
        fetchBatteryInfo()
    }
    
    func fetchBatteryInfo() {
        let device = WKInterfaceDevice.current()
        device.isBatteryMonitoringEnabled = true
        
        let batteryLevelNumber = String(format: "%.0f", device.batteryLevel * 100)
        batteryLevel = batteryLevelNumber + "%"
        
        lowPowerMode = ProcessInfo.processInfo.isLowPowerModeEnabled ? "Yes" : "No"
        
        let batteryStateEnum = device.batteryState
        
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
