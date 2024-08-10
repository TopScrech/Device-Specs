import ScrechKit
import CoreLocation
import CoreMotion

@Observable
class AltitudeVM: NSObject {
    private var altimeter = CMAltimeter()
    private var locationManager = CLLocationManager()
    
    var relativeAltitude = "0.0 m"
    var absoluteAltitude = "0.0 m"
    
    override init() {
        super.init()
        setupLocationManager()
        fetchRelativeAltitude()
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func fetchRelativeAltitude() {
        if CMAltimeter.isRelativeAltitudeAvailable() {
            altimeter.startRelativeAltitudeUpdates(to: .main) { [weak self] data, _ in
                if let data {
                    let relativeAlt = data.relativeAltitude.doubleValue
                    
                    withAnimation {
                        self?.relativeAltitude = String(format: "%.2f m", relativeAlt)
                    }
                }
            }
        }
    }
    
    deinit {
        altimeter.stopRelativeAltitudeUpdates()
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
