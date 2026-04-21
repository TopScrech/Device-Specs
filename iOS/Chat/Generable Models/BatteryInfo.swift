import FoundationModels

@Generable
@available(iOS 26, *)
struct BatteryInfo {
    @Guide(description: "Is the device in low power mode or not")
    let lowPowerMode: Bool
}
