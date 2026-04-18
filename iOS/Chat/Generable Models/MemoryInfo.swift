import FoundationModels

@Generable
@available(iOS 26, *)
struct MemoryInfo {
    @Guide(description: "Total RAM of this device")
    let totalRAM: String
    
    @Guide(description: "Used RAM of this device")
    let usedRAM: String
    
    @Guide(description: "Free RAM of this device")
    let freeRAM: String
}
