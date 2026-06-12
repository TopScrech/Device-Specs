import SwiftUI
import CoreMotion

@Observable
final class OrientationVM {
    private var motionManager = CMMotionManager()
    @ObservationIgnored private var orientationNotificationTask: Task<Void, Never>?
    private var isMonitoring = false
    
    // Rotation
    private(set) var roll = "0.0g"
    private(set) var pitch = "0.0g"
    private(set) var yaw = "0.0g"
    
    // Acceleration
    private(set) var x = "0.0g"
    private(set) var y = "0.0g"
    private(set) var z = "0.0g"
    
    private(set) var orientation = ""
    
    func onAppear() {
        guard !isMonitoring else {
            return
        }
        
        isMonitoring = true
        startFetchingMotionData()
        listenToDeviceOrientation()
    }
    
    private func startFetchingMotionData() {
        guard motionManager.isDeviceMotionAvailable else {
            return
        }
        
        motionManager.deviceMotionUpdateInterval = 1
        
        motionManager.startDeviceMotionUpdates(to: .main) { motion, error in
            guard let motion else {
                return
            }
            
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
    
    private func listenToDeviceOrientation() {
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()
        updateOrientation(UIDevice.current.orientation)
        
        orientationNotificationTask = Task { @MainActor [weak self] in
            for await _ in NotificationCenter.default.notifications(named: UIDevice.orientationDidChangeNotification) {
                self?.updateOrientation(UIDevice.current.orientation)
            }
        }
    }
    
    private func updateOrientation(_ deviceOrientation: UIDeviceOrientation) {
        switch deviceOrientation {
        case .portrait:
            orientation = "Portrait"
            
        case .portraitUpsideDown:
            orientation = "Portrait Upside Down"
            
        case .landscapeLeft:
            orientation = "Landscape Left"
            
        case .landscapeRight:
            orientation = "Landscape Right"
            
        case .faceUp:
            orientation = "Face Up"
            
        case .faceDown:
            orientation = "Face Down"
            
        default:
            orientation = "Unknown"
        }
    }
    
    @MainActor
    deinit {
        orientationNotificationTask?.cancel()
        motionManager.stopDeviceMotionUpdates()
        UIDevice.current.endGeneratingDeviceOrientationNotifications()
    }
}
