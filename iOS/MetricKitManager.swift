#if canImport(MetricKit)
import MetricKit
#endif

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
    
    func didReceive(_ payloads: [MXMetricPayload]) {
        payloads.forEach {
            print("Received metrics:", $0)
        }
    }
    
    func didReceive(_ diagnosticPayloads: [MXDiagnosticPayload]) {
        diagnosticPayloads.forEach {
            print("Received diagnostics:", $0)
        }
    }
}
