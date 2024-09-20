import SwiftUI
import CoreMotion

@Observable
final class MagneticFieldVM: NSObject, CLLocationManagerDelegate {
    // MARK: - Published Properties
    
    // Raw Magnetic Field Data
    var rawMagneticField: MagneticField? = nil
    
    // Calibrated Magnetic Field Data
    var calibratedMagneticField: MagneticField? = nil
    
    // Heading Data
    var heading: CLHeading? = nil
    var headingAccuracy: CLLocationDirection? = nil
    
    // Authorization and Error States
    var authorizationStatus: CLAuthorizationStatus = .notDetermined
    var locationError: Error? = nil
    var motionError: Error? = nil
    
    // MARK: - Private Properties
    
    private var motionManager: CMMotionManager
    private var locationManager: CLLocationManager
    
    // MARK: - Initialization
    
    override init() {
        motionManager = CMMotionManager()
        locationManager = CLLocationManager()
        super.init()
        locationManager.delegate = self
        requestLocationAuthorization()
        startMagnetometerUpdates()
        startDeviceMotionUpdates()
        startLocationUpdates()
    }
    
    deinit {
        stopMagnetometerUpdates()
        stopDeviceMotionUpdates()
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
            guard let self = self else { return }
            
            if let error = error {
                print("Magnetometer error: \(error.localizedDescription)")
                self.motionError = error
                return
            }
            
            guard let data = data else {
                print("No magnetometer data available.")
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
    }
    
    private func startDeviceMotionUpdates() {
        guard motionManager.isDeviceMotionAvailable else {
            print("Device Motion is not available on this device.")
            return
        }
        
        motionManager.deviceMotionUpdateInterval = 1.0 / 60.0 // 60 Hz
        motionManager.startDeviceMotionUpdates(to: .main) { [weak self] data, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Device Motion error: \(error.localizedDescription)")
                self.motionError = error
                return
            }
            
            guard let data = data else {
                print("No device motion data available.")
                return
            }
            
            // Update calibrated magnetic field data
            self.calibratedMagneticField = MagneticField(
                x: data.magneticField.field.x,
                y: data.magneticField.field.y,
                z: data.magneticField.field.z
            )
        }
    }
    
    private func stopDeviceMotionUpdates() {
        motionManager.stopDeviceMotionUpdates()
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
        // Update heading data and accuracy
        heading = newHeading
        headingAccuracy = newHeading.headingAccuracy
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationError = error
        print("Location Manager Error: \(error.localizedDescription)")
    }
}
