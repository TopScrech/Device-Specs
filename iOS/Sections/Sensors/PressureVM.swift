import ScrechKit
import CoreMotion

@Observable
final class PressureVM {
    private var altimeter = CMAltimeter()
    private var isMonitoring = false
    
    private(set) var pressureKilo: String?
    
    func onAppear() {
        guard !isMonitoring else {
            return
        }
        
        isMonitoring = true
        fetchPressureData()
    }
    
    @MainActor
    deinit {
        altimeter.stopRelativeAltitudeUpdates()
    }
    
    func fetchPressureData() {
        guard CMAltimeter.isRelativeAltitudeAvailable() else {
            return
        }
        
        altimeter.startRelativeAltitudeUpdates(to: .main) { @Sendable [weak self] data, _ in
            guard let data else {
                return
            }
            
            let pressureInKilopascals = data.pressure.doubleValue
            
            Task { @MainActor [weak self] in
                self?.pressureKilo = pressureInKilopascals.formatted(.number.precision(.fractionLength(2))) + " kPa"
            }
        }
    }
}
