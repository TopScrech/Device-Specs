#if canImport(MetricKit)
import MetricKit
#endif
import OSLog

@Observable
final class MetricKitManager: NSObject, MXMetricManagerSubscriber {
    static let shared = MetricKitManager()
    
    override init() {
        super.init()
        MXMetricManager.shared.add(self)
    }
    
    @MainActor
    deinit {
        MXMetricManager.shared.remove(self)
    }
    
    nonisolated func didReceive(_ payloads: [MXMetricPayload]) {
        let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "DeviceSpecs", category: "MetricKitManager")
        payloads.forEach {
            logger.info("Received metrics: \(String(describing: $0))")
        }
    }
    
    nonisolated func didReceive(_ diagnosticPayloads: [MXDiagnosticPayload]) {
        let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "DeviceSpecs", category: "MetricKitManager")
        diagnosticPayloads.forEach {
            logger.info("Received diagnostics: \(String(describing: $0))")
        }
    }
}
