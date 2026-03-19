import SwiftUI

@Observable
final class ProximityVM {
    private(set) var isDeviceCloseToUser = false
    
    private var isMonitoring = false
    
    func onAppear() {
        guard !isMonitoring else {
            return
        }
        
        isMonitoring = true
        UIDevice.current.isProximityMonitoringEnabled = true
        
        isDeviceCloseToUser = UIDevice.current.proximityState
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(proximityStateDidChange),
            name: UIDevice.proximityStateDidChangeNotification,
            object: nil
        )
    }
    
    @MainActor
    deinit {
        UIDevice.current.isProximityMonitoringEnabled = false
        
        NotificationCenter.default.removeObserver(
            self,
            name: UIDevice.proximityStateDidChangeNotification,
            object: nil
        )
    }
    
    @objc private func proximityStateDidChange() {
        isDeviceCloseToUser = UIDevice.current.proximityState
    }
}
