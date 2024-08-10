import Foundation
import Darwin

@Observable
final class MemoryVM {
    var totalMemory: UInt64 = 0
    var usedMemory: UInt64 = 0
    var freeMemory: UInt64 = 0
    
    init() {
        if let memoryUsage = getMemoryUsage() {
            self.totalMemory = memoryUsage.total
            self.usedMemory = memoryUsage.used
            self.freeMemory = memoryUsage.free
        }
    }
    
    func getMemoryUsage() -> (total: UInt64, used: UInt64, free: UInt64)? {
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
            
            return (total: totalMemory, used: usedMemory, free: freeMemory)
        }
        
        return nil
    }
}
