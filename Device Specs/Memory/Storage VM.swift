import ScrechKit

@Observable
final class StorageVM {
    var total = ""
    var used = ""
    var available = ""
    
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
            
            if let totalCapacity, let availableCapacity {
                let usedCapacity = totalCapacity - availableCapacity
                used = formatBytes(usedCapacity, countStyle: .decimal)
            } else {
                used = "Unavailable"
            }
        } catch {
            available = "Error"
            total = "Error"
            used = "Error"
            print(error.localizedDescription)
        }
    }
}
