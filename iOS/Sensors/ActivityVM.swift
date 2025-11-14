#if canImport(CoreMotion)
import SwiftUI
@preconcurrency import CoreMotion

@Observable
final class ActivityVM {
    private(set) var activity = ""
    private(set) var confidence = ""
    
    private let motionActivityManager = CMMotionActivityManager()
    
    init() {
        initialize()
    }
    
    private func initialize() {
        guard CMMotionActivityManager.isActivityAvailable() else {
            return
        }
        
        motionActivityManager.startActivityUpdates(to: .main) { [weak self] activity in
            self?.updateActivity(activity)
        }
    }
    
    private func updateActivity(_ activityData: CMMotionActivity?) {
        guard let activityData else {
            return
        }
        
        switch true {
        case activityData.walking:
            activity = "Walking"
            
        case activityData.running:
            activity = "Running"
            
        case activityData.automotive:
            activity = "Automotive"
            
        case activityData.cycling:
            activity = "Cycling"
            
        case activityData.stationary:
            activity = "Stationary"
            
        default:
            activity = "Unknown"
        }
        
        switch activityData.confidence {
        case .low:
            confidence = "Low"
            
        case .medium:
            confidence = "Medium"
            
        case .high:
            confidence = "High"
            
        @unknown default:
            confidence = "Unknown"
        }
    }
    
    deinit {
        motionActivityManager.stopActivityUpdates()
    }
}
#endif
