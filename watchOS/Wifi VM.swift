import SwiftUI
import Network

@Observable
final class WifiVM {
    private let monitor = NWPathMonitor()
    
    var networkStatus = ""
    
    init() {
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
                    self.networkStatus = "Wi-Fi"
                    
                case path.usesInterfaceType(.cellular):
                    self.networkStatus = "Cellular"
                    
                case path.usesInterfaceType(.wiredEthernet):
                    self.networkStatus = "Wired Ethernet"
                    
                case path.usesInterfaceType(.loopback):
                    self.networkStatus = "Loopback Interface"
                    
                case path.usesInterfaceType(.other):
                    self.networkStatus = "Other Interface"
                    
                default:
                    self.networkStatus = "No Interface"
                }
            }
        }
    }
}
