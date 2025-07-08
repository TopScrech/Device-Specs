import ScrechKit

struct NetworkSpecs: View {
    @State private var network = NetworkVM()
    @Environment(ConnectivityVM.self) private var connectivity
    
    var body: some View {
        List {
            ListParam("Public IP address", param: network.publicIp)
            
            ListParam("Network interface", param: network.networkinterface)
            
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
            }
        }
        .navigationTitle("Network")
        .refreshableTask {
            network.getIPAddresses()
            connectivity.getWiFiInfo()
        }
    }
}

#Preview {
    NetworkSpecs()
        .environment(ConnectivityVM())
}
