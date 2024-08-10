import ScrechKit
import CoreMotion

@Observable
final class PressureVM {
    private var altimeter = CMAltimeter()
    
    var pressureKilo = ""
    var pressureHecto = ""
    
    init() {
        fetchPressureData()
    }
    
    func fetchPressureData() {
        if CMAltimeter.isRelativeAltitudeAvailable() {
            altimeter.startRelativeAltitudeUpdates(to: .main) { [weak self] data, error in
                if let data {
                    let pressureInKilopascals = data.pressure.doubleValue
                    
                    withAnimation {
                        self?.pressureKilo = String(format: "%.2f kPa", pressureInKilopascals)
                    }
                }
            }
        }
    }
    
    deinit {
        altimeter.stopRelativeAltitudeUpdates()
    }
}
