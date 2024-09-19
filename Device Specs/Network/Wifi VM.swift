import SwiftUI
import SystemConfiguration.CaptiveNetwork
import Network

@Observable
final class WifiVM {
    private let monitor = NWPathMonitor()
    
    var type = ""
    var ssid = ""
    var bssid = ""
    
    init() {
        getWiFiInfo()
        monitorNetworkStatus()
    }
    
    private func monitorNetworkStatus() {
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self else {
                return
            }
            
            DispatchQueue.main.async {
                switch true {
                case path.usesInterfaceType(.wifi):
                    self.type = "Wi-Fi"
                    self.getWiFiInfo()
                    
                case path.usesInterfaceType(.cellular):
                    self.type = "Cellular"
                    
                case path.usesInterfaceType(.wiredEthernet):
                    self.type = "Wired Ethernet"
                    
                case path.usesInterfaceType(.loopback):
                    self.type = "Loopback Interface"
                    
                case path.usesInterfaceType(.other):
                    self.type = "Other Interface"
                    
                default:
                    self.type = "No Interface"
                }
            }
        }
    }
    
    private func getWiFiInfo() {
        guard let interfaces = CNCopySupportedInterfaces() as? [String] else {
            print("Failed to fetch interfaces")
            return
        }
        
        guard let interface = interfaces.first else {
            print("Failed to fetch interface")
            return
        }
        
        guard let info = CNCopyCurrentNetworkInfo(interface as CFString) as? [String: Any] else {
            print("Failed to fetch network info")
            return
        }
        
        if let ssid = info[kCNNetworkInfoKeySSID as String] as? String {
            self.ssid = ssid
        } else {
            print("Failed to fetch SSID")
        }
        
        if let bssid = info[kCNNetworkInfoKeyBSSID as String] as? String {
            self.bssid = bssid
        } else {
            print("Failed to fetch BSSID")
        }
    }
}
