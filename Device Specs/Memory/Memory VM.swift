import ScrechKit
import DeviceKit

@Observable
final class MemoryVM {
    private let device = Device.current
    
    var totalRam = ""
    var usedRam = ""
    var freeRam = ""
    
    var totalDisk = ""
    var usedDisk = ""
    var freeDisk = ""
    var freeDiskForImportantUsage = ""
    var freeDiskForOpportunisticUsage = ""
    
    init() {
        getMemoryUsage()
        getDiskInfo()
    }
    
    var totalRamAndDisk: String {
        "\(totalRam) & \(totalDisk)"
    }
    
    var memoryType: String {
        device.cpu.memoryType
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
            let totalMemoryBytes = ProcessInfo.processInfo.physicalMemory
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
#if os(watchOS) || os(tvOS)
            let values = try fileURL.resourceValues(forKeys: [
                .volumeTotalCapacityKey,
                .volumeAvailableCapacityKey,
            ])
#else
            let values = try fileURL.resourceValues(forKeys: [
                .volumeTotalCapacityKey,
                .volumeAvailableCapacityKey,
                .volumeAvailableCapacityForImportantUsageKey,
                .volumeAvailableCapacityForOpportunisticUsageKey
            ])
            
            let availableCapacityForImportantUsage = values.volumeAvailableCapacityForImportantUsage
            let availableCapacityForOpportunisticUsage = values.volumeAvailableCapacityForOpportunisticUsage
            
            if let availableCapacityForOpportunisticUsage {
                freeDiskForOpportunisticUsage = formatBytes(availableCapacityForOpportunisticUsage)
            } else {
                freeDiskForOpportunisticUsage = "Unavailable"
            }
            
            if let availableCapacityForImportantUsage {
                freeDiskForImportantUsage = formatBytes(availableCapacityForImportantUsage)
            } else {
                freeDiskForImportantUsage = "Unavailable"
            }
#endif
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
