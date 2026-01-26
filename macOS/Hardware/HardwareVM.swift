import Foundation
import OSLog

@Observable
final class HardwareVM {
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "DeviceSpecs", category: "HardwareVM")
    var modelName = "Unknown"
    var modelIdentifier = "Unknown"
    var modelNumber = "Unknown"
    var chip = "Unknown"
    var totalNumberOfCores = "Unknown"
    var memory = "Unknown"
    var systemFirmwareVersion = "Unknown"
    var osLoaderVersion = "Unknown"
    var serialNumber = "Unknown"
    var hardwareUUID = "Unknown"
    var provisioningUDID = "Unknown"
    var activationLockStatus = "Unknown"
    
    init() {
        fetchHardwareInfo()
    }
    
    func fetchHardwareInfo() {
        Task { [logger] in
            let output = await Task.detached(priority: .background) {
                await Self.runSystemProfiler()
            }.value
            guard let output else {
                logger.error("Failed to fetch system information")
                return
            }
            
            let values = Self.parseOutput(output)
            apply(values)
        }
    }
    
    private func apply(_ values: HardwareValues) {
        modelName = values.modelName
        modelIdentifier = values.modelIdentifier
        modelNumber = values.modelNumber
        chip = values.chip
        totalNumberOfCores = values.totalNumberOfCores
        memory = values.memory
        systemFirmwareVersion = values.systemFirmwareVersion
        osLoaderVersion = values.osLoaderVersion
        serialNumber = values.serialNumber
        hardwareUUID = values.hardwareUUID
        provisioningUDID = values.provisioningUDID
        activationLockStatus = values.activationLockStatus
    }
    
    private static func parseOutput(_ output: String) -> HardwareValues {
        var values = HardwareValues()
        let lines = output.components(separatedBy: "\n")
        
        for line in lines {
            let trimmedLine = line.trimmingCharacters(in: .whitespaces)
            
            switch trimmedLine {
            case let x where x.starts(with: "Model Name:"):
                values.modelName = extractValue(x)
                
            case let x where x.starts(with: "Model Identifier:"):
                values.modelIdentifier = extractValue(x)
                
            case let x where x.starts(with: "Model Number:"):
                values.modelNumber = extractValue(x)
                
            case let x where x.starts(with: "Chip:"):
                values.chip = extractValue(x)
                
            case let x where x.starts(with: "Total Number of Cores:"):
                values.totalNumberOfCores = extractValue(x)
                
            case let x where x.starts(with: "Memory:"):
                values.memory = extractValue(x)
                
            case let x where x.starts(with: "System Firmware Version:"):
                values.systemFirmwareVersion = extractValue(x)
                
            case let x where x.starts(with: "OS Loader Version:"):
                values.osLoaderVersion = extractValue(x)
                
            case let x where x.starts(with: "Serial Number (system):"):
                values.serialNumber = extractValue(x)
                
            case let x where x.starts(with: "Hardware UUID:"):
                values.hardwareUUID = extractValue(x)
                
            case let x where x.starts(with: "Provisioning UDID:"):
                values.provisioningUDID = extractValue(x)
                
            case let x where x.starts(with: "Activation Lock Status:"):
                values.activationLockStatus = extractValue(x)
            default:
                break
            }
        }
        
        return values
    }
    
    private static func runSystemProfiler() -> String? {
        let task = Process()
        let pipe = Pipe()
        
        task.launchPath = "/usr/sbin/system_profiler"
        task.arguments = ["SPHardwareDataType"]
        task.standardOutput = pipe
        task.standardError = nil
        
        do {
            try task.run()
        } catch {
            Logger().error("Error running system_profiler: \(error)")
            return nil
        }
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        task.waitUntilExit()
        
        return String(data: data, encoding: .utf8)
    }
    
    private static func extractValue(_ line: String) -> String {
        let components = line.components(separatedBy: ":")
        
        if components.count > 1 {
            return components[1].trimmingCharacters(in: .whitespaces)
        }
        
        return "Unknown"
    }
    
    private struct HardwareValues {
        var modelName = "Unknown"
        var modelIdentifier = "Unknown"
        var modelNumber = "Unknown"
        var chip = "Unknown"
        var totalNumberOfCores = "Unknown"
        var memory = "Unknown"
        var systemFirmwareVersion = "Unknown"
        var osLoaderVersion = "Unknown"
        var serialNumber = "Unknown"
        var hardwareUUID = "Unknown"
        var provisioningUDID = "Unknown"
        var activationLockStatus = "Unknown"
    }
}
