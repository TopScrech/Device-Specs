import FoundationModels

@Generable
@available(iOS 26, *)
struct CPUInfo {
    @Guide(description: "Name of the CPU on this device")
    let name: String
    
    @Guide(description: "Technode of the CPU on this device, represented in nanometers (nm)")
    let technode: String
    
    @Guide(description: "Max clock speed of the CPU on this device")
    let maxClockSpeed: String
}
