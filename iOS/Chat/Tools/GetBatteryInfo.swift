import SwiftUI
import FoundationModels

@available(iOS 26, *)
struct GetBatteryInfo: Tool {
    let name = "getBatteryInfo"
    let description = "Gets the current battery level, battery state, and Low Power Mode status of this device"
    
    @Generable
    struct Arguments {}
    
    func call(arguments: Arguments) async throws -> BatteryInfo {
        let snapshot = await MainActor.run {
            let device = UIDevice.current
            device.isBatteryMonitoringEnabled = true
            
            return (
                level: Double(device.batteryLevel),
                state: batteryStateDescription(device.batteryState)
            )
        }
        
        let batteryLevel = snapshot.level
        let level = batteryLevel >= 0 ? Int(batteryLevel * 100) : nil
        let formattedLevel = batteryLevel >= 0 ? batteryLevel.formatted(.percent.precision(.fractionLength(0))) : "Unknown"
        
        return BatteryInfo(
            level: level,
            formattedLevel: formattedLevel,
            state: snapshot.state,
            lowPowerMode: ProcessInfo.processInfo.isLowPowerModeEnabled
        )
    }
    
    private func batteryStateDescription(_ state: UIDevice.BatteryState) -> String {
        switch state {
        case .unknown: "Unknown"
        case .unplugged: "Unplugged"
        case .charging: "Charging"
        case .full: "Full"
        @unknown default: "Unknown"
        }
    }
}
