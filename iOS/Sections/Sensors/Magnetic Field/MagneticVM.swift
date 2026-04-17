import SwiftUI
import CoreMotion
import OSLog

@Observable
final class MagneticVM: NSObject {
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "DeviceSpecs", category: "MagneticVM")
    var rawMagneticField: MagneticField? = nil
    
    private var motionManager: CMMotionManager
    private var isMonitoring = false
    
    override init() {
        motionManager = CMMotionManager()
        super.init()
    }
    
    func onAppear() {
        guard !isMonitoring else {
            return
        }
        
        isMonitoring = true
        startMagnetometerUpdates()
    }
    
    @MainActor
    deinit {
        stopMagnetometerUpdates()
    }
    
    private func startMagnetometerUpdates() {
        guard motionManager.isMagnetometerAvailable else {
            logger.warning("Magnetometer is not available on this device")
            return
        }
        
        logger.info("Starting Magnetometer Updates")
        motionManager.magnetometerUpdateInterval = 1
        
        motionManager.startMagnetometerUpdates(to: .main) { [weak self] data, error in
            guard let self else { return }
            
            if let error {
                logger.error("Magnetometer error: \(error)")
                return
            }
            
            guard let data else {
                logger.warning("No magnetometer data available")
                return
            }
            
            // Update raw magnetic field data
            self.rawMagneticField = MagneticField(
                x: data.magneticField.x,
                y: data.magneticField.y,
                z: data.magneticField.z
            )
        }
    }
    
    private func stopMagnetometerUpdates() {
        motionManager.stopMagnetometerUpdates()
        logger.info("Stopped Magnetometer Updates")
    }
}
