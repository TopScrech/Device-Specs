import ScrechKit

struct NetworkSpecs: View {
    @State private var network = NetworkVM()
    @Environment(ConnectivityVM.self) private var connectivity
    
#warning("Router differs from settings")
    var body: some View {
        List {
            ListParam("Public IP address", param: network.publicIp)
            
            ListParam("Network interface", param: network.networkinterface)
            
            ListParam("Router", param: network.router)
            
            ListParam("Subnet mask", param: network.subnetMask)
            
            Section {
                ListParam("Network type", param: connectivity.type)
                
                ListParam("SSID", param: connectivity.ssid)
                
                ListParam("BSSID", param: connectivity.bssid)
            }
        }
        .navigationTitle("Network")
        .refreshableTask {
            network.getIPAddresses()
        }
    }
}

#Preview {
    NetworkSpecs()
        .environment(ConnectivityVM())
}
