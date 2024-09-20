import Foundation

@Observable
final class AppVM {
    private let info = ProcessInfo()
    
    var version: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "-"
    }
    
    var build: String {
        Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "-"
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
}
