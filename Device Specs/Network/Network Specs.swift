import ScrechKit

struct NetworkSpecs: View {
    @State private var network = NetworkVM()
    @Environment(ConnectivityVM.self) private var connectivity
    
    var body: some View {
        List {
            ListParam("Public IP address", param: network.publicIp)
            
            ListParam("Network interface", param: network.networkInterface)
            
            ListParam("Destination IP address", param: network.destinationIpAddress)
            
            if let router = RouterVM().fetch() {
                ListParam("Router", param: router)
            }
            
            ListParam("Subnet mask", param: network.subnetMask)
            
            Section {
                ListParam("Network type", param: connectivity.type)
                
                if let ssid = connectivity.ssid {
                    ListParam("SSID", param: ssid)
                }
                
                if let bssid = connectivity.bssid {
                    ListParam("BSSID", param: bssid)
                }
                
                if let signalStrength = connectivity.signalStrength {
                    ListParam("Signal strength", param: String(format: "%.0f%%", signalStrength * 100))
                }
                
                if let isSecure = connectivity.isSecure {
                    ListParam("Secure network", param: isSecure ? "Yes" : "No")
                }
                
                if let didAutoJoin = connectivity.didAutoJoin {
                    ListParam("Auto-joined", param: didAutoJoin ? "Yes" : "No")
                }
                
                if let didJustJoin = connectivity.didJustJoin {
                    ListParam("Just joined", param: didJustJoin ? "Yes" : "No")
                }
                
                if let isChosenHelper = connectivity.isChosenHelper {
                    ListParam("Hotspot Helper", param: isChosenHelper ? "Yes" : "No")
                }
                
                if let securityType = connectivity.securityType {
                    ListParam("Security type", param: securityType)
                }
            }
        }
        .navigationTitle("Network")
        .refreshableTask {
            async let getIPAddresses: () = network.getIPAddresses()
            async let getWiFiInfo: () = connectivity.getWiFiInfo()
            
            _ = await (getIPAddresses, getWiFiInfo)
        }
    }
}

#Preview {
    NetworkSpecs()
        .environment(ConnectivityVM())
}
