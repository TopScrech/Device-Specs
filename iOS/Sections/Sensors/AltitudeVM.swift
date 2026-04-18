import ScrechKit
import CoreLocation
import CoreMotion

@Observable
final class AltitudeVM: NSObject {
    private var altimeter = CMAltimeter()
    private var locationManager = CLLocationManager()
    private var isMonitoring = false
    
    private(set) var relativeAltitude = "0.0 m"
    private(set) var absoluteAltitude = "0.0 m"
    
    override init() {
        super.init()
    }
    
    func onAppear() {
        guard !isMonitoring else {
            return
        }
        
        isMonitoring = true
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
                    
                    self?.relativeAltitude = String(format: "%.2f m", relativeAlt)
                }
            }
        }
    }
    
    @MainActor
    deinit {
        altimeter.stopRelativeAltitudeUpdates()
        locationManager.stopUpdatingLocation()
    }
}

extension AltitudeVM: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let latestLocation = locations.last {
            Task { @MainActor [weak self] in
                self?.absoluteAltitude = String(format: "%.2f m", latestLocation.altitude)
            }
        }
    }
}
