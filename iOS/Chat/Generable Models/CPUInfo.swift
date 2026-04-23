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
    
    @Guide(description: "Amount of neural engine cores")
    let neuralEngineCores: String
    
    @Guide(description: "Performance of the neural engine, represented in TOPS (trillion operations per second)")
    let neuralEngineTOPS: String
}
