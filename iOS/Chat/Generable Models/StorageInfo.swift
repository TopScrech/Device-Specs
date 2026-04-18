import FoundationModels

@Generable
@available(iOS 26, *)
struct StorageInfo {
    @Guide(description: "Total storage")
    var totalDisk: String
    
    @Guide(description: "Used storage")
    var usedDisk: String
    
    @Guide(description: "Free storage")
    var freeDisk: String
}
