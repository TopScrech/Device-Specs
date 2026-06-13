import FoundationModels

@Generable
@available(iOS 26, *)
struct BatteryInfo {
    @Guide(description: "Battery level as a percentage from 0 to 100, or nil when unavailable")
    let level: Int?
    
    @Guide(description: "Formatted battery level percentage, or Unknown when unavailable")
    let formattedLevel: String
    
    @Guide(description: "Current battery state")
    let state: String
    
    @Guide(description: "Is the device in low power mode or not")
    let lowPowerMode: Bool
}
