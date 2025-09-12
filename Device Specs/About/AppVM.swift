import Foundation

@Observable
final class AppVM {
    var trigger = false
    
    var version: String {
        Bundle.version ?? "-"
    }
    
    private var build: String {
        Bundle.build ?? "-"
    }
    
    var versionAndBuild: String {
        "v\(version) (B\(build))"
    }
}
