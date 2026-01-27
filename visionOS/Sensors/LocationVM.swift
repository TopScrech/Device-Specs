import SwiftUI
import CoreLocation
import OSLog

@Observable
final class LocationVM: NSObject, CLLocationManagerDelegate {
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "DeviceSpecs", category: "LocationVM")
    private(set) var latitude = 0.0
    private(set) var longitude = 0.0
    
    private var locationManager: CLLocationManager
    
    override init() {
        locationManager = CLLocationManager()
        super.init()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinates = locations.first?.coordinate else {
            return
        }
        
        withAnimation {
            latitude = coordinates.latitude
            longitude = coordinates.longitude
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        logger.error("Failed to update location: \(error)")
    }
}

//func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//    if let location = locations.first {
//        if location.horizontalAccuracy <= someThreshold {
//            // GPS is likely available and providing accurate location data
//        }
//    }
//}
