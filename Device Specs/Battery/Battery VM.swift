import SwiftUI
import DeviceKit

@Observable
final class BatteryVM {
    var batteryLevel = ""
    var batteryState = ""
    var lowPowerMode = ""
    
    init() {
        fetchBatteryInfo()
    }
    
    var color: Color {
        if lowPowerMode == "Yes" {
            .yellow
        } else {
            batteryState == "Charging" ? .green : .primary
        }
    }
    
    var icon: String {
#if os(watchOS)
        let battery = WKInterfaceDevice.current().batteryLevel * 100
#else
        let battery = UIDevice.current.batteryLevel * 100
#endif
        
        switch battery {
        case 0...24:
            return "battery.0percent"
            
        case 25...49:
            return "battery.25percent"
            
        case 50...74:
            return "battery.50percent"
            
        case 75...89:
            return "battery.75percent"
            
        case 90...100:
            return "battery.100percent"
            
        default:
            return "battery.0percent"
        }
    }
    
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
        batteryLevel = batteryLevelNumber + " %"
        
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
