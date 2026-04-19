import FoundationModels

@Generable
@available(iOS 26, *)
struct DeviceInfo {
    @Guide(description: "Name of this device")
    let name: String
    
    @Guide(description: "Bluetooth version")
    let bluetoothVersion: String
    
    @Guide(description: "Thermal state")
    let thermalState: String
    
    /// isUWBAvailable makes the AI think that UWB is called UWBA
    @Guide(description: "Ultra Wide Band (UWB) availability")
    let is_UWB_available: Bool
    
    @Guide(description: "MagSafe capability")
    let isMagSafeAvailable: Bool
    
    @Guide(description: "Charging port")
    let dockConnector: String
    
    @Guide(description: "Dynamic Island support")
    let hasDymanicIsland: Bool
    
    @Guide(description: "5G support")
    let support5G: Bool
    
    @Guide(description: "Wireless charging support")
    let supportWirelessCharging: Bool
}
