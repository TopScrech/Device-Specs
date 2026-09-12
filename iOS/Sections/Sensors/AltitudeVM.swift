import ScrechKit
import CoreLocation
@preconcurrency import CoreMotion

@Observable
final class AltitudeVM: NSObject {
    private nonisolated(unsafe) let altimeter = CMAltimeter()
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
        startRelativeAltitudeUpdates()
    }

    private nonisolated func startRelativeAltitudeUpdates() {
        guard CMAltimeter.isRelativeAltitudeAvailable() else {
            return
        }

        altimeter.startRelativeAltitudeUpdates(to: .main) { [weak self] data, _ in
            guard let data else {
                return
            }

            let relativeAltitude = data.relativeAltitude.doubleValue

            Task { @MainActor [weak self] in
                self?.relativeAltitude = relativeAltitude.formatted(.number.precision(.fractionLength(2))) + " m"
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
            absoluteAltitude = latestLocation.altitude.formatted(.number.precision(.fractionLength(2))) + " m"
        }
    }
}
