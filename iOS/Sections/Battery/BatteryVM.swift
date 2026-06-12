import SwiftUI
import DeviceKit

@Observable
final class BatteryVM {
    private let device = Device.current
    
    private(set) var batteryLevel = ""
    private(set) var batteryState = ""
    private(set) var batteryLevelNumber: Int?
    private(set) var lowPowerMode = false
    
    @ObservationIgnored private var batteryNotificationTasks: [Task<Void, Never>] = []
    
#if os(watchOS)
    private var batteryTimer: Timer?
#endif
    
    init() {
        // Enable monitoring
        setupBatteryMonitoring()
        
        // Initial fetch
        fetchBatteryInfo()
        
        // Setup observers
        setupNotifications()
    }
    
    // Disable battery monitoring
    @MainActor
    deinit {
        batteryNotificationTasks.forEach { $0.cancel() }
        
#if os(watchOS)
        WKInterfaceDevice.current().isBatteryMonitoringEnabled = false
#else
        UIDevice.current.isBatteryMonitoringEnabled = false
#endif
    }
    
    var capacity: String {
        device.batteryCapacity
    }
    
    var voltage: String {
        device.voltage
    }
    
    var color: Color {
        if lowPowerMode {
            .yellow
        } else {
            batteryState == "Charging" ? .green : .primary
        }
    }
    
    var icon: String {
#if os(watchOS)
        let battery = WKInterfaceDevice.current().batteryLevel * 100
#else
        let battery = UIDevice.current.batteryLevel * 100
#endif
        switch battery {
        case 0...24:
            return "battery.0percent"
            
        case 25...49:
            return "battery.25percent"
            
        case 50...74:
            return "battery.50percent"
            
        case 75...89:
            return "battery.75percent"
            
        case 90...100:
            return "battery.100percent"
            
        default:
            return "battery.0percent"
        }
    }
    
    // MARK: - Setup Methods
    
    private func setupBatteryMonitoring() {
#if os(watchOS)
        let device = WKInterfaceDevice.current()
#else
        let device = UIDevice.current
#endif
        device.isBatteryMonitoringEnabled = true
    }
    
    private func setupNotifications() {
#if os(watchOS)
        batteryTimer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { [weak self] _ in
            Task { @MainActor in
                self?.fetchBatteryInfo()
            }
        }
#else
        batteryNotificationTasks = [
            Task { @MainActor [weak self] in
                for await _ in NotificationCenter.default.notifications(named: UIDevice.batteryLevelDidChangeNotification) {
                    self?.fetchBatteryInfo()
                }
            },
            Task { @MainActor [weak self] in
                for await _ in NotificationCenter.default.notifications(named: UIDevice.batteryStateDidChangeNotification) {
                    self?.fetchBatteryInfo()
                }
            }
        ]
#endif
    }
    
    // MARK: - Fetch Battery Info
    
    func fetchBatteryInfo() {
#if os(watchOS)
        let device = WKInterfaceDevice.current()
#else
        let device = UIDevice.current
#endif
        withAnimation {
            batteryLevelNumber = Int(device.batteryLevel * 100)
            batteryLevel = device.batteryLevel.formatted(.percentRounded)
            lowPowerMode = ProcessInfo.processInfo.isLowPowerModeEnabled
            
            switch device.batteryState {
            case .unknown:
                batteryState = "Unknown"
                
            case .unplugged:
                batteryState = "Unplugged"
                
            case .charging:
                batteryState = "Charging"
                
            case .full:
                batteryState = "Full"
                
            default:
                batteryState = "Unknown"
            }
        }
    }
}
