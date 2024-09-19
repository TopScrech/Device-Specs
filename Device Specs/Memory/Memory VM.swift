import ScrechKit

@Observable
final class MemoryVM {
    var totalDisk = ""
    var usedDisk = ""
    var freeDisk = ""
    
    var totalRam = ""
    var usedRam = ""
    var freeRam = ""
    
    private let totalMemoryBytes = ProcessInfo.processInfo.physicalMemory
    
    init() {
        getMemoryUsage()
        getDiskInfo()
    }
    
    var totalRamAndDisk: String {
        let ram = roundUp(formatBytes(totalMemoryBytes))
        
        return "\(ram) / \(totalDisk)"
    }
    
    private func roundUp(_ value: String) -> String {
        let components = value.split(separator: " ")
        if components.count == 2, let number = Double(components[0]) {
            let roundedNumber = Int(ceil(number))
            return "\(roundedNumber) \(components[1])"
        }
        return value
    }
    
    // Memory
    func getMemoryUsage() {
        var size = mach_msg_type_number_t(MemoryLayout<vm_statistics_data_t>.size / MemoryLayout<integer_t>.size)
        let host = mach_host_self()
        var stats = vm_statistics_data_t()
        
        let status = withUnsafeMutablePointer(to: &stats) {
            $0.withMemoryRebound(to: integer_t.self, capacity: Int(size)) {
                host_statistics(host, HOST_VM_INFO, $0, &size)
            }
        }
        
        if status == KERN_SUCCESS {
            let pageSize = vm_kernel_page_size
            let usedMemory = (UInt64(stats.active_count) + UInt64(stats.inactive_count) + UInt64(stats.wire_count)) * UInt64(pageSize)
            let freeMemory = totalMemoryBytes - usedMemory
            
            totalRam = formatBytes(totalMemoryBytes)
            usedRam = formatBytes(usedMemory)
            freeRam = formatBytes(freeMemory)
        }
    }
    
    // Storage
    func getDiskInfo() {
        let fileURL = URL(fileURLWithPath: NSHomeDirectory() as String)
        
        do {
            let values = try fileURL.resourceValues(forKeys: [
                .volumeAvailableCapacityKey,
                .volumeTotalCapacityKey
            ])
            
            let totalCapacity = values.volumeTotalCapacity
            let availableCapacity = values.volumeAvailableCapacity
            
            if let totalCapacity {
                totalDisk = formatBytes(totalCapacity)
            } else {
                totalDisk = "Unavailable"
            }
            
            if let availableCapacity {
                freeDisk = formatBytes(availableCapacity)
            } else {
                freeDisk = "Unavailable"
            }
            
            if let totalCapacity, let availableCapacity {
                let usedCapacity = totalCapacity - availableCapacity
                usedDisk = formatBytes(usedCapacity)
            } else {
                usedDisk = "Unavailable"
            }
        } catch {
            freeDisk = "Error"
            totalDisk = "Error"
            usedDisk = "Error"
            
            print(error.localizedDescription)
        }
    }
}
