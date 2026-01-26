#if canImport(MetricKit)
import MetricKit
#endif
import OSLog

@Observable
final class MetricKitManager: NSObject, MXMetricManagerSubscriber {
    static let shared = MetricKitManager()
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "DeviceSpecs", category: "MetricKitManager")
    
    override init() {
        super.init()
        MXMetricManager.shared.add(self)
    }
    
    @MainActor
    deinit {
        MXMetricManager.shared.remove(self)
    }
    
    func didReceive(_ payloads: [MXMetricPayload]) {
        payloads.forEach {
            logger.info("Received metrics: \(String(describing: $0))")
        }
    }
    
    func didReceive(_ diagnosticPayloads: [MXDiagnosticPayload]) {
        diagnosticPayloads.forEach {
            logger.info("Received diagnostics: \(String(describing: $0))")
        }
    }
}
