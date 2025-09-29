import Foundation

@Observable
final class AppVM {
    var trigger = false
    
    let version = Bundle.version ?? "-"
    private let build = Bundle.build ?? "-"
    
    var versionAndBuild: String {
        "v\(version) (B\(build))"
    }
}
