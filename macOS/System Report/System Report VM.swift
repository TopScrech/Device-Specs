import SwiftUI

@Observable
final class SystemReportVM {
    var output = ""
    var progress = 0.0
    var isFetching = false
    var reportURL: URL?
    
    func saveFileToLocation(_ name: String) {
        guard let url = reportURL else {
            return
        }
        
        let savePanel = NSSavePanel()
        savePanel.title = "Choose save location"
        savePanel.allowedContentTypes = .init([.text])
        savePanel.nameFieldStringValue = url.lastPathComponent
        
        savePanel.begin { response in
            if response == .OK, let destinationUrl = savePanel.url {
                do {
                    try FileManager.default.moveItem(at: url, to: destinationUrl)
                    print("File moved successfully to: \(destinationUrl.path)")
                } catch {
                    print("Failed to move file: \(error)")
                }
            }
        }
    }
    
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
                            progress = min(1, progress + 0.005)
                        }
                    }
                } else {
                    // EOF
                    fileHandle.readabilityHandler = nil
                    
                    DispatchQueue.main.async { [self] in
                        withAnimation {
                            isFetching = false
                        }
                        
                        progress = 1
                        
                        // After completion, save the output to a file
                        saveOutputToFile()
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
    
    private func saveOutputToFile() {
        let fileName = "\(Date.now.description).txt"
        let tempDirectory = FileManager.default.temporaryDirectory
        let fileURL = tempDirectory.appendingPathComponent(fileName)
        
        do {
            try output.write(to: fileURL, atomically: true, encoding: .utf8)
            reportURL = fileURL
            print("File saved successfully at: \(fileURL.path)")
        } catch {
            print("Failed to save file: \(error)")
        }
    }
}
