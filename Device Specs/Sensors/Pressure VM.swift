import ScrechKit
import CoreMotion

@Observable
final class PressureVM {
    private var altimeter = CMAltimeter()
    
    var pressureKilo: String?
    var pressureHecto = ""
    
    init() {
        fetchPressureData()
    }
    
    deinit {
        altimeter.stopRelativeAltitudeUpdates()
    }
    
    func fetchPressureData() {
        guard CMAltimeter.isRelativeAltitudeAvailable() else {
            return
        }
        
        altimeter.startRelativeAltitudeUpdates(to: .main) { [weak self] data, error in
            guard let data else {
                return
            }
            
            let pressureInKilopascals = data.pressure.doubleValue
            
            self?.pressureKilo = String(format: "%.2f kPa", pressureInKilopascals)
        }
    }
}
