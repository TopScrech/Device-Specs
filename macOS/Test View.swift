import SwiftUI

struct TestView: View {
    var body: some View {
        Button("Test") {
            if let systemReport = fetchSystemReport() {
                print(systemReport)
            } else {
                print("Failed to fetch system report.")
            }
        }
    }
    
    func fetchSystemReport() -> String? {
        let task = Process()
        let pipe = Pipe()
        
        task.launchPath = "/usr/sbin/system_profiler"
        task.arguments = ["-detailLevel", "full"]
        task.standardOutput = pipe
        task.standardError = pipe
        
        do {
            try task.run()
        } catch {
            print("Failed to run system_profiler command: \(error)")
            return nil
        }
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        task.waitUntilExit()
        
        guard task.terminationStatus == 0 else {
            print("system_profiler command failed with status \(task.terminationStatus)")
            return nil
        }
        
        if let output = String(data: data, encoding: .utf8) {
            return output
        } else {
            print("Failed to decode system_profiler output.")
            return nil
        }
    }
}

#Preview {
    TestView()
}
