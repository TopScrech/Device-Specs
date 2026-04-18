import FoundationModels

@Generable
@available(iOS 26, *)
struct StorageInfo {
    @Guide(description: "Total storage of this device")
    var totalDisk: String
    
    @Guide(description: "Used storage of this device")
    var usedDisk: String
    
    @Guide(description: "Free storage of this device")
    var freeDisk: String
}
