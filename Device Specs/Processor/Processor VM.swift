import Foundation

@Observable
final class ProcessorVM {
    var cores = 0
    var activeCores = 0
    
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
        cores = ProcessInfo.processInfo.processorCount // COre count
        activeCores = ProcessInfo.processInfo.activeProcessorCount // Active core count
    }
}
