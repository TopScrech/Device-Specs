import SwiftUI
import CoreMotion

@Observable
final class MagneticFieldViewModel: NSObject, CLLocationManagerDelegate {
    var magneticField = MagneticField(x: 0, y: 0, z: 0)
    var rawMagneticField: MagneticField? = nil
    var headingAccuracy: CLLocationDirection? = nil
    var authorizationStatus: CLAuthorizationStatus = .notDetermined
    var locationError: Error? = nil
    
    private var motionManager: CMMotionManager
    private var locationManager: CLLocationManager
    
    override init() {
        motionManager = CMMotionManager()
        locationManager = CLLocationManager()
        super.init()
        locationManager.delegate = self
        requestLocationAuthorization()
        startMagnetometerUpdates()
        startLocationUpdates()
    }
    
    deinit {
        stopMagnetometerUpdates()
        stopLocationUpdates()
    }
    
    // MARK: - Core Motion
    
    private func startMagnetometerUpdates() {
        guard motionManager.isMagnetometerAvailable else {
            print("Magnetometer is not available on this device.")
            return
        }
        
        motionManager.magnetometerUpdateInterval = 1.0 / 60.0 // 60 Hz
        motionManager.startMagnetometerUpdates(to: .main) { [weak self] data, error in
            guard let self = self, let data = data else {
                if let error = error {
                    print("Magnetometer error: \(error.localizedDescription)")
                }
                return
            }
            
            // Update normal magnetic field data
            self.magneticField = MagneticField(
                x: data.magneticField.x,
                y: data.magneticField.y,
                z: data.magneticField.z
            )
            
            // Update raw magnetic field data if available
            if let calibratedData = data as? CMMagnetometerData {
                self.rawMagneticField = MagneticField(
                    x: calibratedData.magneticField.x,
                    y: calibratedData.magneticField.y,
                    z: calibratedData.magneticField.z
                )
            }
        }
    }
    
    private func stopMagnetometerUpdates() {
        motionManager.stopMagnetometerUpdates()
    }
    
    // MARK: - Core Location
    
    private func requestLocationAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    private func startLocationUpdates() {
        if CLLocationManager.headingAvailable() {
            locationManager.headingFilter = kCLHeadingFilterNone
            locationManager.startUpdatingHeading()
        } else {
            print("Heading updates are not available on this device.")
        }
    }
    
    private func stopLocationUpdates() {
        locationManager.stopUpdatingHeading()
    }
    
    // MARK: - CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        authorizationStatus = status
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            startLocationUpdates()
            
        case .denied, .restricted:
            print("Location access denied or restricted.")
            
        case .notDetermined:
            print("Location access not determined.")
            
        @unknown default:
            print("Unknown location authorization status.")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        // Update heading accuracy
        headingAccuracy = newHeading.headingAccuracy
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationError = error
        print("Location Manager Error: \(error.localizedDescription)")
    }
}
