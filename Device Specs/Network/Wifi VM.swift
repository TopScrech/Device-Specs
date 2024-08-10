import SwiftUI
import SystemConfiguration.CaptiveNetwork
import Network

@Observable
final class WifiVM {
    let monitor = NWPathMonitor()
    
    var networkStatus = ""
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
            switch true {
            case path.usesInterfaceType(.wifi):
                self?.networkStatus = "Wi-Fi"
                self?.getWiFiInfo() // Fetch Wi-Fi info when interface is active
                
            case path.usesInterfaceType(.cellular):
                self?.networkStatus = "Cellular"
                
            case path.usesInterfaceType(.wiredEthernet):
                self?.networkStatus = "Wired Ethernet"
                
            case path.usesInterfaceType(.loopback):
                self?.networkStatus = "Loopback Interface"
                
            case path.usesInterfaceType(.other):
                self?.networkStatus = "Other Interface"
                
            default:
                self?.networkStatus = "No Interface"
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
        
        guard let ssid = info[kCNNetworkInfoKeySSID as String] as? String else {
            print("Failed to fetch SSID")
            return
        }
        
        guard let bssid = info[kCNNetworkInfoKeyBSSID as String] as? String else {
            print("Failed to fetch BSSID")
            return
        }
        
        self.ssid = ssid
        self.bssid = bssid
    }
}
