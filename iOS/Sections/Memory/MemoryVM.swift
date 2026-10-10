import ScrechKit
import DeviceKit
import OSLog

@Observable
final class MemoryVM {
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "DeviceSpecs", category: "MemoryVM")
    private let device = Device.current

    private var liveTotalRAM = ""
    private var liveUsedRAM = ""
    private var liveFreeRAM = ""
    private var liveTotalDisk = ""
    private var liveUsedDisk = ""
    private var liveFreeDisk = ""
    private var liveFreeDiskForImportantUsage = ""
    private var liveFreeDiskForOpportunisticUsage = ""
    
    var totalRAM: String {
        ValueStore.debugValue(liveTotalRAM, override: "12 GB")
    }

    var usedRAM: String {
        ValueStore.debugValue(liveUsedRAM, override: "6 GB (50%)")
    }

    var freeRAM: String {
        ValueStore.debugValue(liveFreeRAM, override: "6 GB (50%)")
    }
    
    var totalDisk: String {
        ValueStore.debugValue(liveTotalDisk, override: "2 TB")
    }

    var usedDisk: String {
        ValueStore.debugValue(liveUsedDisk, override: "1.5 TB (75%)")
    }

    var freeDisk: String {
        ValueStore.debugValue(liveFreeDisk, override: "512 GB (25%)")
    }
    
    var freeDiskForImportantUsage: String {
        ValueStore.debugValue(liveFreeDiskForImportantUsage, override: "512 GB (25%)")
    }

    var freeDiskForOpportunisticUsage: String {
        ValueStore.debugValue(liveFreeDiskForOpportunisticUsage, override: "512 GB (25%)")
    }
    
    init() {
        getMemoryUsage()
    }
    
    var totalRamAndDisk: String {
        if totalRAM.isEmpty {
            return totalDisk
        }
        
        if totalDisk.isEmpty {
            return totalRAM
        }
        
        return "\(totalRAM) & \(totalDisk)"
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
        
        liveTotalRAM = formatBytes(totalMemory)
        
        liveUsedRAM = format(Int(totalMemory), Int(usedMemory))
        liveFreeRAM = format(Int(totalMemory), Int(freeMemory))
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
                liveFreeDiskForOpportunisticUsage = "Unavailable"
                liveFreeDiskForImportantUsage = "Unavailable"
                
                return
            }
#endif
            guard
                let totalCapacity = values.volumeTotalCapacity,
                let availableCapacity = values.volumeAvailableCapacity
            else {
                liveFreeDisk = "N/a"
                liveUsedDisk = "N/a"
                liveTotalDisk = "N/a"
                
                return
            }
            
            guard totalCapacity > 0 else {
                liveFreeDisk = "N/a"
                liveUsedDisk = "N/a"
                liveTotalDisk = "N/a"
                
                return
            }
            
#if os(watchOS) || os(tvOS)
            let clampedAvailableCapacity = max(0, min(availableCapacity, totalCapacity))
            let usedCapacity = max(0, totalCapacity - clampedAvailableCapacity)
            
            liveFreeDisk = format(totalCapacity, clampedAvailableCapacity)
#else
            let clampedAvailableCapacityForOpportunisticUsage = max(0, min(Int(availableCapacityForOpportunisticUsage), totalCapacity))
            let clampedAvailableCapacityForImportantUsage = max(0, min(Int(availableCapacityForImportantUsage), totalCapacity))
            
            liveFreeDiskForOpportunisticUsage = format(totalCapacity, clampedAvailableCapacityForOpportunisticUsage)
            liveFreeDiskForImportantUsage = format(totalCapacity, clampedAvailableCapacityForImportantUsage)
            
            let usedCapacity = max(0, totalCapacity - clampedAvailableCapacityForImportantUsage)
            
            liveFreeDisk = format(totalCapacity, clampedAvailableCapacityForImportantUsage)
#endif
            
            liveTotalDisk = formatBytes(totalCapacity)
            liveUsedDisk = format(totalCapacity, usedCapacity)
        } catch {
            liveFreeDisk = "Error"
            liveTotalDisk = "Error"
            liveUsedDisk = "Error"
            
            logger.error("Failed to read disk info: \(error)")
        }
    }
    
    private func format(_ total: Int, _ value: Int) -> String {
        let percentage = Double(value) / Double(total) * 100
        let percentageString = String(format: " (%.1f%%)", percentage)
        
        return formatBytes(value) + percentageString
    }
}
