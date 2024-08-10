import ScrechKit

@Observable
final class StorageVM {
    var available = ""
    var total = ""
//    var systemSize = ""
    
    init() {
        fetchStorageInfo()
    }
    
    func fetchStorageInfo() {
        let fileURL = URL(fileURLWithPath: NSHomeDirectory() as String)
        
        do {
            let values = try fileURL.resourceValues(forKeys: [
                .volumeAvailableCapacityKey,
                .volumeTotalCapacityKey
            ])
            
            let totalCapacity = values.volumeTotalCapacity
            let availableCapacity = values.volumeAvailableCapacity
            
            if let totalCapacity {
                total = formatBytes(totalCapacity, countStyle: .decimal)
            } else {
                total = "Unavailable"
            }
            
            if let availableCapacity {
                available = formatBytes(availableCapacity, countStyle: .decimal)
            } else {
                available = "Unavailable"
            }
        } catch {
            available = "Error"
            total = "Error"
            print(error.localizedDescription)
        }
    }
}
