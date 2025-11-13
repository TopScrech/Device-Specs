import ScrechKit
import CoreLocation
import CoreMotion

@Observable
class AltitudeVM: NSObject {
    private var locationManager = CLLocationManager()
    
    private(set) var relativeAltitude = "0.0 m"
    private(set) var absoluteAltitude = "0.0 m"
    
    override init() {
        super.init()
        setupLocationManager()
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    @MainActor
    deinit {
        locationManager.stopUpdatingLocation()
    }
}

extension AltitudeVM: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let latestLocation = locations.last {
            DispatchQueue.main.async {
                self.absoluteAltitude = String(format: "%.2f m", latestLocation.altitude)
            }
        }
    }
}
