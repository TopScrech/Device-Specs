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
    
    deinit {
        MXMetricManager.shared.remove(self)
    }
    
#if !os(macOS)
    func didReceive(_ payloads: [MXMetricPayload]) {
        for payload in payloads {
            print("Received metrics:", payload)
        }
    }
    
    func didReceive(_ diagnosticPayloads: [MXDiagnosticPayload]) {
        for payload in diagnosticPayloads {
            print("Received diagnostics:", payload)
        }
    }
#endif
}
