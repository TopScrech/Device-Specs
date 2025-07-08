import SwiftUI
import Network

@Observable
final class ConnectivityVM {
    private let monitor = NWPathMonitor()
    
    private(set) var type = ""
    
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
    }
}
