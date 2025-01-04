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
            let totalMemory = ProcessInfo.processInfo.physicalMemory
            
            let pageSize = vm_kernel_page_size
            let usedMemory = (UInt64(stats.active_count) + UInt64(stats.inactive_count) + UInt64(stats.wire_count)) * UInt64(pageSize)
            let freeMemory = totalMemory - usedMemory
            
            totalRam = formatBytes(totalMemory)
            
            usedRam = format(Int(totalMemory), Int(usedMemory))
            freeRam = format(Int(totalMemory), Int(freeMemory))
        }
    }
    
    // Storage
    func getDiskInfo() {
        let fileURL = URL(fileURLWithPath: NSHomeDirectory() as String)
        
        do {
#if os(watchOS) || os(tvOS)
            let values = try fileURL.resourceValues(forKeys: [
                .volumeTotalCapacityKey,
                .volumeAvailableCapacityKey
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
            
            guard
                let availableCapacityForOpportunisticUsage,
                let availableCapacityForImportantUsage
            else {
                freeDiskForOpportunisticUsage = "Unavailable"
                freeDiskForImportantUsage = "Unavailable"
                
                return
            }
#endif
            guard
                let totalCapacity = values.volumeTotalCapacity,
                let availableCapacity = values.volumeAvailableCapacity
            else {
                freeDisk = "N/a"
                usedDisk = "N/a"
                totalDisk = "N/a"
                
                return
            }
            
#if os(watchOS) || os(tvOS)
            let usedCapacity = totalCapacity - availableCapacity
            
            freeDisk = format(totalCapacity, availableCapacity)
#else
            freeDiskForOpportunisticUsage = format(totalCapacity, Int(availableCapacityForOpportunisticUsage))
            freeDiskForImportantUsage = format(totalCapacity, Int(availableCapacityForImportantUsage))
            
            let usedCapacity = totalCapacity - Int(availableCapacityForImportantUsage)
            
            freeDisk = format(totalCapacity, Int(availableCapacityForImportantUsage))
#endif
            
            totalDisk = formatBytes(totalCapacity)
            usedDisk = format(totalCapacity, usedCapacity)
        } catch {
            freeDisk = "Error"
            totalDisk = "Error"
            usedDisk = "Error"
            
            print(error.localizedDescription)
        }
    }
    
    private func format(_ total: Int, _ value: Int) -> String {
        let percentage = Double(value) / Double(total) * 100
        let percentageString = String(format: " (%.1f%%)", percentage)
        
        let formattedValue = formatBytes(value)
        
        return formattedValue + percentageString
    }
}
