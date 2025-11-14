import SwiftUI
import CoreMotion
import Combine

@Observable
final class OrientationVM {
    private var motionManager = CMMotionManager()
    
    // Rotation
    private(set) var roll = "0.0g"
    private(set) var pitch = "0.0g"
    private(set) var yaw = "0.0g"
    
    // Acceleration
    private(set) var x = "0.0g"
    private(set) var y = "0.0g"
    private(set) var z = "0.0g"
    
    init() {
        startFetchingMotionData()
    }
    
    private func startFetchingMotionData() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 1
            
            motionManager.startDeviceMotionUpdates(to: .main) { motion, _ in
                guard let motion else {
                    return
                }
                
                withAnimation {
                    let attitude = motion.attitude
                    let acceleration = motion.userAcceleration
                    
                    self.roll = String(format: "%.2fg", attitude.roll)
                    self.pitch = String(format: "%.2fg", attitude.pitch)
                    self.yaw = String(format: "%.2fg", attitude.yaw)
                    
                    self.x = String(format: "%.2fg", acceleration.x)
                    self.y = String(format: "%.2fg", acceleration.y)
                    self.z = String(format: "%.2fg", acceleration.z)
                }
            }
        }
    }
    
    @MainActor
    deinit {
        motionManager.stopDeviceMotionUpdates()
    }
}
