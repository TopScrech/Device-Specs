import Foundation
import FoundationModels

@available(iOS 26, *)
struct GetBatteryInfo: Tool {
    let name = "getBatteryInfo"
    let description = "Gets information about the battery of this device"
    
    @Generable
    struct Arguments {}
    
    func call(arguments: Arguments) async throws -> BatteryInfo {
        BatteryInfo(lowPowerMode: ProcessInfo.processInfo.isLowPowerModeEnabled)
    }
}
