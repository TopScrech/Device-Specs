import ScrechKit
import DeviceKit
import OSLog

@Observable
final class MemoryVM {
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "DeviceSpecs", category: "MemoryVM")
    private let device = Device.current
    
    private(set) var totalRam = ""
    private(set) var usedRam = ""
    private(set) var freeRam = ""
    
    private(set) var totalDisk = ""
    private(set) var usedDisk = ""
    private(set) var freeDisk = ""
    private(set) var freeDiskForImportantUsage = ""
    private(set) var freeDiskForOpportunisticUsage = ""
    
    init() {
        getMemoryUsage()
    }
    
    var totalRamAndDisk: String {
        if totalRam.isEmpty {
            return totalDisk
        }
        
        if totalDisk.isEmpty {
            return totalRam
        }
        
        return "\(totalRam) & \(totalDisk)"
    }
    
    var memoryType: String {
        device.cpu.memoryType
    }
    
    // Memory
    func getMemoryUsage() {
        var stats = vm_statistics64()
        var size = mach_msg_type_number_t(MemoryLayout.size(ofValue: stats) / MemoryLayout<Int32>.stride)
        let host = mach_host_self()
        
        let status = withUnsafeMutablePointer(to: &stats) {
            $0.withMemoryRebound(to: integer_t.self, capacity: Int(size)) {
                host_statistics64(host, HOST_VM_INFO64, $0, &size)
            }
        }
        
        guard status == KERN_SUCCESS else {
            return
        }
        
        let totalMemory = ProcessInfo.processInfo.physicalMemory
        var pageSize: vm_size_t = 0
        host_page_size(host, &pageSize)
        
        let usedMemory = (UInt64(stats.active_count) + UInt64(stats.wire_count)) * UInt64(pageSize)
        let freeMemory = totalMemory - usedMemory
        
        totalRam = formatBytes(totalMemory)
        
        usedRam = format(Int(totalMemory), Int(usedMemory))
        freeRam = format(Int(totalMemory), Int(freeMemory))
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
            
            guard totalCapacity > 0 else {
                freeDisk = "N/a"
                usedDisk = "N/a"
                totalDisk = "N/a"
                
                return
            }
            
#if os(watchOS) || os(tvOS)
            let clampedAvailableCapacity = max(0, min(availableCapacity, totalCapacity))
            let usedCapacity = max(0, totalCapacity - clampedAvailableCapacity)
            
            freeDisk = format(totalCapacity, clampedAvailableCapacity)
#else
            let clampedAvailableCapacityForOpportunisticUsage = max(0, min(Int(availableCapacityForOpportunisticUsage), totalCapacity))
            let clampedAvailableCapacityForImportantUsage = max(0, min(Int(availableCapacityForImportantUsage), totalCapacity))
            
            freeDiskForOpportunisticUsage = format(totalCapacity, clampedAvailableCapacityForOpportunisticUsage)
            freeDiskForImportantUsage = format(totalCapacity, clampedAvailableCapacityForImportantUsage)
            
            let usedCapacity = max(0, totalCapacity - clampedAvailableCapacityForImportantUsage)
            
            freeDisk = format(totalCapacity, clampedAvailableCapacityForImportantUsage)
#endif
            
            totalDisk = formatBytes(totalCapacity)
            usedDisk = format(totalCapacity, usedCapacity)
        } catch {
            freeDisk = "Error"
            totalDisk = "Error"
            usedDisk = "Error"
            
            logger.error("Failed to read disk info: \(error)")
        }
    }
    
    private func format(_ total: Int, _ value: Int) -> String {
        let percentage = Double(value) / Double(total) * 100
        let percentageString = String(format: " (%.1f%%)", percentage)
        
        return formatBytes(value) + percentageString
    }
}
