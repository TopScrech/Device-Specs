import Foundation

@Observable
final class AppVM {
    private let info = ProcessInfo()
    let bundleId = Bundle.main.bundleIdentifier ?? "-"
    
    var version: String {
        Bundle.version ?? "-"
    }
    
    private var build: String {
        Bundle.build ?? "-"
    }
    
    var versionAndBuild: String {
        "v\(version) (B\(build))"
    }
    
    var minimumOSVersion: String {
        Bundle.main.object(forInfoDictionaryKey: "MinimumOSVersion") as? String ?? "Unknown"
    }
    
    var trigger = false
    
    var isMacCatalystApp: String {
        info.isMacCatalystApp ? "Yes" : "No"
    }
    
    var isiOSAppOnMac: String {
        info.isiOSAppOnMac ? "Yes" : "No"
    }
    
    var getAppInstallationDate: String? {
        guard
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first,
            let attributes = try? FileManager.default.attributesOfItem(atPath: documentsURL.path),
            let creationDate = attributes[.creationDate] as? Date
        else {
            return nil
        }
        
        return creationDate.formatted()
    }
}
