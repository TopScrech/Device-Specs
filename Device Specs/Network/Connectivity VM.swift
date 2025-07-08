import ScrechKit
import NetworkExtension

@Observable
final class ConnectivityVM {
    private let monitor = NWPathMonitor()
    
    var type = ""
    var ssid: String? = nil
    var bssid: String? = nil
    
    init() {
        getWiFiInfo()
        monitorNetworkStatus()
    }
    
    private func monitorNetworkStatus() {
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        
        monitor.pathUpdateHandler = { [weak self] path in
            self?.getWiFiInfo()
            
            guard let self else {
                return
            }
            
            switch true {
            case path.usesInterfaceType(.wifi):
                self.type = "Wi-Fi"
                
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
    
    func getWiFiInfo() {
        NEHotspotNetwork.fetchCurrent { network in
            self.ssid = network?.ssid
            self.bssid = network?.bssid
        }
    }
}
