import SwiftUI
import CoreMotion

@Observable
final class MagneticVM: NSObject {
    var rawMagneticField: MagneticField? = nil
    
    private var motionManager: CMMotionManager
    
    override init() {
        motionManager = CMMotionManager()
        super.init()
        startMagnetometerUpdates()
    }
    
    deinit {
        stopMagnetometerUpdates()
    }
    
    private func startMagnetometerUpdates() {
        guard motionManager.isMagnetometerAvailable else {
            print("Magnetometer is not available on this device")
            return
        }
        
        print("Starting Magnetometer Updates...")
        motionManager.magnetometerUpdateInterval = 1
        
        motionManager.startMagnetometerUpdates(to: .main) { [weak self] data, error in
            guard let self else {
                return
            }
            
            if let error {
                print("Magnetometer error: \(error.localizedDescription)")
                return
            }
            
            guard let data else {
                print("No magnetometer data available")
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
        print("Stopped Magnetometer Updates")
    }
}
