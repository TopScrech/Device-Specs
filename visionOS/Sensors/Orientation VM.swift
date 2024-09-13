import SwiftUI
import CoreMotion
import Combine

@Observable
final class OrientationVM {
    private var motionManager = CMMotionManager()
    private var cancellables = Set<AnyCancellable>()
    
    // Rotation
    var roll = "0.0g"
    var pitch = "0.0g"
    var yaw = "0.0g"
    
    // Acceleration
    var x = "0.0g"
    var y = "0.0g"
    var z = "0.0g"
    
    init() {
        startFetchingMotionData()
    }
    
    private func startFetchingMotionData() {
        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 1
            motionManager.startDeviceMotionUpdates(to: .main) { motion, error in
                guard let motion else {
                    return
                }
                
                withAnimation {
                    self.roll = String(format: "%.2fg", motion.attitude.roll)
                    self.pitch = String(format: "%.2fg", motion.attitude.pitch)
                    self.yaw = String(format: "%.2fg", motion.attitude.yaw)
                    
                    self.x = String(format: "%.2fg", motion.userAcceleration.x)
                    self.y = String(format: "%.2fg", motion.userAcceleration.y)
                    self.z = String(format: "%.2fg", motion.userAcceleration.z)
                }
            }
        }
    }
    
    deinit {
        motionManager.stopDeviceMotionUpdates()
    }
}
