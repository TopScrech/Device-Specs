import SwiftUI
import DeviceKit
import Combine

@Observable
final class BatteryVM {
    private let device = Device.current
    
    private(set) var batteryLevel = ""
    private(set) var batteryState = ""
    private(set) var batteryLevelNumber: Int?
    private(set) var lowPowerMode = ""
    
    private var cancellables = Set<AnyCancellable>()
    
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
    deinit {
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
    
    var capacityWh: String {
        device.power
    }
    
    var color: Color {
        if lowPowerMode == "Yes" {
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
            self?.fetchBatteryInfo()
        }
#else
        // Observe battery level changes
        NotificationCenter.default.publisher(for: UIDevice.batteryLevelDidChangeNotification)
            .sink { [weak self] _ in
                self?.fetchBatteryInfo()
            }
            .store(in: &cancellables)
        
        // Observe battery state changes
        NotificationCenter.default.publisher(for: UIDevice.batteryStateDidChangeNotification)
            .sink { [weak self] _ in
                self?.fetchBatteryInfo()
            }
            .store(in: &cancellables)
#endif
    }
    
    // MARK: - Fetch Battery Info
    
    func fetchBatteryInfo() {
#if os(watchOS)
        let device = WKInterfaceDevice.current()
        let batteryLvlNumber = String(format: "%.0f", device.batteryLevel * 100)
        let batteryStateEnum = device.batteryState
#else
        let device = UIDevice.current
        
        
        let batteryLvlNumber = String(format: "%.0f", device.batteryLevel * 100)
        let batteryStateEnum = device.batteryState
#endif
        withAnimation {
            batteryLevelNumber = Int(device.batteryLevel * 100)
            
            // Update battery level
            batteryLevel = "\(batteryLvlNumber) %"
            
            // Update Low Power Mode status
            lowPowerMode = ProcessInfo.processInfo.isLowPowerModeEnabled ? "Yes" : "No"
            
            // Update battery state
            switch batteryStateEnum {
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
