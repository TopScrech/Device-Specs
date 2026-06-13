#if canImport(CoreMotion)
import SwiftUI
import OSLog
@preconcurrency import CoreMotion

@Observable
final class ActivityVM {
    private(set) var activity = ""
    private(set) var confidence = ""
    private(set) var status: CMAuthorizationStatus? = nil
    
    private let motionActivityManager = CMMotionActivityManager()
    private var isMonitoring = false
    
    func onAppear() {
        guard !isMonitoring else {
            return
        }
        
        isMonitoring = true
        initialize()
    }
    
    private func initialize() {
        guard CMMotionActivityManager.isActivityAvailable() else {
            Logger().info("Unavailable")
            return
        }
        
        status = CMMotionActivityManager.authorizationStatus()
        
        switch status {
        case .authorized:
            Logger().info("Access granted")
            
        case .notDetermined:
            Logger().info("Requesting access")
            
        case .denied:
            Logger().info("Access denied")
            return
            
        case .restricted:
            Logger().info("Access restricted")
            return
            
        default:
            Logger().info("Access unavailable")
            return
        }
        
        motionActivityManager.startActivityUpdates(to: .main) { [weak self] activity in
            self?.updateActivity(activity)
        }
    }
    
    private func updateActivity(_ activityData: CMMotionActivity?) {
        guard let activityData else { return }
        
        let updatedActivity: String
        switch true {
        case activityData.walking:
            updatedActivity = "Walking"
            
        case activityData.running:
            updatedActivity = "Running"
            
        case activityData.automotive:
            updatedActivity = "Automotive"
            
        case activityData.cycling:
            updatedActivity = "Cycling"
            
        case activityData.stationary:
            updatedActivity = "Stationary"
            
        default:
            updatedActivity = "Unknown"
        }
        
        let updatedConfidence: String
        
        switch activityData.confidence {
        case .low:
            updatedConfidence = "Low"
            
        case .medium:
            updatedConfidence = "Medium"
            
        case .high:
            updatedConfidence = "High"
            
        @unknown default:
            updatedConfidence = "Unknown"
        }
        
        if activity != updatedActivity {
            activity = updatedActivity
        }
        
        if confidence != updatedConfidence {
            confidence = updatedConfidence
        }
    }
    
    deinit {
        motionActivityManager.stopActivityUpdates()
    }
}
#endif
