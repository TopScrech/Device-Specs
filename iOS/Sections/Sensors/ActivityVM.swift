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
        
        Logger().info("Motion access granted")
        
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
        case .low: confidence = "Low"
        case .medium: confidence = "Medium"
        case .high: confidence = "High"
        @unknown default: confidence = "Unknown"
        }
    }
    
    deinit {
        motionActivityManager.stopActivityUpdates()
    }
}
#endif
