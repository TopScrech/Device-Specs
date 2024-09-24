import Foundation
import DeviceKit

@Observable
final class ProcessorVM {
    private let info = ProcessInfo.processInfo
    private let cpu = Device.current.cpu
    
    var cpuNameAndTechnology: String {
        "\(cpuName) (\(techNode)nm)"
    }
    
    var cpuName: String {
        cpu.description
    }
    
    var techNode: String {
        cpu.nanometers
    }
    
    var cpuUsage: [Double] = []
    
    var cores: Int {
        info.processorCount
    }
    
    var activeCores: Int {
        info.activeProcessorCount
    }
    
    var processName: String {
        info.processName
    }
    
    var environment: String {
        info.environment.description
    }
    
    var hostName: String {
        info.hostName
    }
    
    var processIdentifier: String {
        info.processIdentifier.description
    }
    
    var globallyUniqueString: String {
        info.globallyUniqueString
    }
    
    var arguments: String {
        info.arguments.description
    }
    
    var threadCount: String {
        var threadCount = mach_msg_type_number_t()
        var threadList: thread_act_array_t?
        let kerr = task_threads(mach_task_self_, &threadList, &threadCount)
        
        if kerr == KERN_SUCCESS {
            return String(threadCount)
        } else {
            return "-"
        }
    }
    
#if os(iOS)
    var performanceProfile: String {
        if #available(iOS 18, *) {
            if info.hasPerformanceProfile(.sustained) {
                "Sustained"
            } else if info.hasPerformanceProfile(.default) {
                "Default"
            } else {
                "-"
            }
        } else {
            "-"
        }
    }
    
    var sertifiedForIphonePerformanceGaming: String {
        if #available(iOS 18, *) {
            info.isDeviceCertified(for: .iPhonePerformanceGaming) ? "Yes" : "No"
        } else {
            "No"
        }
    }
#endif
    
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
