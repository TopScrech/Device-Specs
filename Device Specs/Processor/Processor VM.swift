import Foundation

@Observable
final class ProcessorVM {
    var cores = 0
    var activeCores = 0
    var cpuUsage: [Double] = []
    
    init() {
        fetchNumberOfCores()
    }
    
    var arch: String {
#if arch(arm64)
        "arm64"
#elseif arch(x86_64)
        "x86_64"
#elseif arch(i386)
        "i386"
#elseif arch(arm)
        "arm"
#else
        "unknown"
#endif
    }
    
    func fetchNumberOfCores() {
        cores = ProcessInfo.processInfo.processorCount
        activeCores = ProcessInfo.processInfo.activeProcessorCount
    }
    
    func cpuUsagePerCore() {
        var numCPUsU: UInt32 = 0
        var cpuInfo: processor_info_array_t!
        var numCPUInfo: mach_msg_type_number_t = 0
        let processorCount = ProcessInfo.processInfo.processorCount
        
        let result = host_processor_info(mach_host_self(), (PROCESSOR_CPU_LOAD_INFO), &numCPUsU, &cpuInfo, &numCPUInfo)
        
        guard result == KERN_SUCCESS else {
            return
        }
        
        var coreUsage = [Double]()
        
        for i in 0..<processorCount {
            let user = Double(cpuInfo[Int(CPU_STATE_MAX * Int32(i) + CPU_STATE_USER)])
            let system = Double(cpuInfo[Int(CPU_STATE_MAX * Int32(i) + CPU_STATE_SYSTEM)])
            let idle = Double(cpuInfo[Int(CPU_STATE_MAX * Int32(i) + CPU_STATE_IDLE)])
            let nice = Double(cpuInfo[Int(CPU_STATE_MAX * Int32(i) + CPU_STATE_NICE)])
            
            let total = user + system + idle + nice
            let usage = (user + system + nice) / total
            
            coreUsage.append(usage)
        }
        
        cpuUsage = coreUsage
    }
}
