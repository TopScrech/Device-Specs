import ScrechKit

struct NetworkSpecs: View {
    @State private var network = NetworkVM()
    @Environment(ConnectivityVM.self) private var connectivity
    
    var body: some View {
#warning("Router differs from settings")
        List {
            ListParameter("Public IP address", parameter: network.publicIp)
            
            ListParameter("Network interface", parameter: network.networkinterface)
            
            ListParameter("Router", parameter: network.router)
            
            ListParameter("Subnet mask", parameter: network.subnetMask)
            
            Section {
                ListParameter("Network type", parameter: connectivity.type)
                ListParameter("SSID", parameter: connectivity.ssid)
                ListParameter("BSSID", parameter: connectivity.bssid)
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
