import FoundationModels

@Generable
@available(iOS 26, *)
struct CPUInfo {
    @Guide(description: "Name of the CPU")
    let name: String
    
    @Guide(description: "Technode of the CPU, represented in nm (nanometers)")
    let technode: String
    
    @Guide(description: "Clock speed of the CPU")
    let clockSpeed: String
}
