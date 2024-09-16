import SwiftUI

@Observable
final class SystemReportVM {
    var output = ""
    var progress = 0.0
    var isFetching = false
    
    func fetchSystemReport() {
        withAnimation {
            isFetching = true
        }
        
        output = ""
        progress = 0.0
        
        DispatchQueue.global(qos: .userInitiated).async {
            let task = Process()
            let pipe = Pipe()
            
            task.launchPath = "/usr/sbin/system_profiler"
            task.arguments = ["-detailLevel", "full"]
            task.standardOutput = pipe
            task.standardError = pipe
            
            let fileHandle = pipe.fileHandleForReading
            
            // Observe the data as it is being read
            fileHandle.readabilityHandler = { handle in
                let data = handle.availableData
                
                if data.count > 0 {
                    if let chunk = String(data: data, encoding: .utf8) {
                        DispatchQueue.main.async { [self] in
                            output += chunk
                            // Update progress (this is a placeholder)
                            progress = min(1.0, progress + 0.005)
                        }
                    }
                } else {
                    // EOF
                    fileHandle.readabilityHandler = nil
                    
                    DispatchQueue.main.async { [self] in
                        isFetching = false
                        progress = 1
                    }
                }
            }
            
            do {
                try task.run()
            } catch {
                DispatchQueue.main.async { [self] in
                    output += "Failed to run system_profiler command: \(error)"
                    isFetching = false
                }
                return
            }
            
            task.waitUntilExit()
            
            if task.terminationStatus != 0 {
                DispatchQueue.main.async { [self] in
                    output += "system_profiler command failed with status \(task.terminationStatus)"
                    isFetching = false
                }
            }
        }
    }
}
