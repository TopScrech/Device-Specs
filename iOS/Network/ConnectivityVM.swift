import Foundation
import NetworkExtension

@Observable
final class ConnectivityVM {
    private let monitor = NWPathMonitor()
    
    private(set) var type = ""
    private(set) var ssid: String? = nil
    private(set) var bssid: String? = nil
    private(set) var signalStrength: Double? // for Wi-Fi
    private(set) var isSecure: Bool?
    private(set) var didAutoJoin: Bool?
    private(set) var didJustJoin: Bool?
    private(set) var isChosenHelper: Bool? // Indicates whether the calling Hotspot Helper is the chosen helper for this network
    private(set) var securityType: String? // for Wi-Fi
    
    init() {
        monitorNetworkStatus()
    }
    
    private func monitorNetworkStatus() {
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        
        monitor.pathUpdateHandler = { path in
            Task { @MainActor in
                await self.getWiFiInfo()
                
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
    
    func getWiFiInfo() async {
        let network = await withCheckedContinuation { continuation in
            NEHotspotNetwork.fetchCurrent { network in
                continuation.resume(returning: network)
            }
        }
        
        self.ssid = network?.ssid
        self.bssid = network?.bssid
        self.signalStrength = network?.signalStrength
        self.isSecure = network?.isSecure
        self.didAutoJoin = network?.didAutoJoin
        self.didJustJoin = network?.didJustJoin
        self.isChosenHelper = network?.isChosenHelper
        self.securityType = self.securityTypeString(network?.securityType)
    }
    
    private func securityTypeString(_ type: NEHotspotNetworkSecurityType?) -> String? {
        switch type {
        case .WEP: "WEP"
        case .enterprise: "Enterprise"
        case .open: "Open"
        case .personal: "Personal"
        case .unknown: "Unknown"
        case .none: "None"
        @unknown default: nil
        }
    }
}
