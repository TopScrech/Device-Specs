import SwiftUI
import CoreLocation

@Observable
final class LocationVM: NSObject, CLLocationManagerDelegate {
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
        if let location = locations.first {
            withAnimation {
                latitude = location.coordinate.latitude
                longitude = location.coordinate.longitude
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to update location: \(error.localizedDescription)")
    }
}

//func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//    if let location = locations.first {
//        if location.horizontalAccuracy <= someThreshold {
//            // GPS is likely available and providing accurate location data
//        }
//    }
//}
