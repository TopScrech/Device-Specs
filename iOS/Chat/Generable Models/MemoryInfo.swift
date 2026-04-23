import FoundationModels

@Generable
@available(iOS 26, *)
struct MemoryInfo {
    @Guide(description: "Total RAM")
    let totalRAM: String
    
    @Guide(description: "Used RAM")
    let usedRAM: String
    
    @Guide(description: "Free RAM")
    let freeRAM: String
}
