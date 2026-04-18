import FoundationModels

@Generable
@available(iOS 26, *)
struct DeviceInfo {
    @Guide(description: "Name of this device")
    let name: String
    
    @Guide(description: "Bluetooth version of this device")
    let bluetoothVersion: String
    
    @Guide(description: "Thermal state of this device")
    let thermalState: String
    
    @Guide(description: "Ultra Wide Band (UWB) availability on this device")
    let is_UWB_available: String
}
