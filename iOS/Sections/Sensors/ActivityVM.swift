#if canImport(CoreMotion)
import SwiftUI
@preconcurrency import CoreMotion

@Observable
final class ActivityVM {
    private(set) var activity = ""
    private(set) var confidence = ""
    private(set) var status = ""
    
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
            status = "Unavailable"
            return
        }
        
        switch CMMotionActivityManager.authorizationStatus() {
        case .authorized:
            status = "Access granted"
            
        case .notDetermined:
            status = "Requesting access"
            
        case .denied:
            status = "Access denied"
            return
            
        case .restricted:
            status = "Access restricted"
            return
            
        @unknown default:
            status = "Access unavailable"
            return
        }
        
        motionActivityManager.startActivityUpdates(to: .main) { [weak self] activity in
            self?.updateActivity(activity)
        }
    }
    
    private func updateActivity(_ activityData: CMMotionActivity?) {
        guard let activityData else { return }
        
        status = "Motion access granted"
        
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
