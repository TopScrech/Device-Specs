import Foundation

@Observable
final class HardwareVM {
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
        DispatchQueue.global(qos: .background).async {
            guard let output = self.runSystemProfiler() else {
                print("Failed to fetch system information.")
                return
            }
            
            let lines = output.components(separatedBy: "\n")
            
            for line in lines {
                let trimmedLine = line.trimmingCharacters(in: .whitespaces)
                switch trimmedLine {
                case let x where x.starts(with: "Model Name:"):
                    
                    self.modelName = self.extractValue(x)
                case let x where x.starts(with: "Model Identifier:"):
                    
                    self.modelIdentifier = self.extractValue(x)
                case let x where x.starts(with: "Model Number:"):
                    
                    self.modelNumber = self.extractValue(x)
                case let x where x.starts(with: "Chip:"):
                    
                    self.chip = self.extractValue(x)
                case let x where x.starts(with: "Total Number of Cores:"):
                    
                    self.totalNumberOfCores = self.extractValue(x)
                case let x where x.starts(with: "Memory:"):
                    
                    self.memory = self.extractValue(x)
                case let x where x.starts(with: "System Firmware Version:"):
                    
                    self.systemFirmwareVersion = self.extractValue(x)
                case let x where x.starts(with: "OS Loader Version:"):
                    
                    self.osLoaderVersion = self.extractValue(x)
                case let x where x.starts(with: "Serial Number (system):"):
                    
                    self.serialNumber = self.extractValue(x)
                case let x where x.starts(with: "Hardware UUID:"):
                    
                    self.hardwareUUID = self.extractValue(x)
                case let x where x.starts(with: "Provisioning UDID:"):
                    
                    self.provisioningUDID = self.extractValue(x)
                case let x where x.starts(with: "Activation Lock Status:"):
                    
                    self.activationLockStatus = self.extractValue(x)
                default:
                    break
                }
            }
        }
    }
    
    private func runSystemProfiler() -> String? {
        let task = Process()
        let pipe = Pipe()
        
        task.launchPath = "/usr/sbin/system_profiler"
        task.arguments = ["SPHardwareDataType"]
        task.standardOutput = pipe
        task.standardError = nil
        
        do {
            try task.run()
        } catch {
            print("Error running system_profiler: \(error)")
            return nil
        }
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        task.waitUntilExit()
        
        return String(data: data, encoding: .utf8)
    }
    
    private func extractValue(_ line: String) -> String {
        let components = line.components(separatedBy: ":")
        
        if components.count > 1 {
            return components[1].trimmingCharacters(in: .whitespaces)
        }
        
        return "Unknown"
    }
}
