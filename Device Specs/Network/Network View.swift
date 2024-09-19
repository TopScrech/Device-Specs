import ScrechKit

struct NetworkSpecs: View {
    @State private var network = NetworkVM()
    @State private var wifi = WifiVM()
    
    var body: some View {
#warning("Router differs from settings")
        List {
            ListParameter("Public IP address", parameter: network.publicIp)
            
            ListParameter("Network interface", parameter: network.networkinterface)
            
            ListParameter("Router", parameter: network.router)
            
            ListParameter("Subnet mask", parameter: network.subnetMask)
            
            Section {
                ListParameter("Network type", parameter: wifi.type)
                ListParameter("SSID", parameter: wifi.ssid)
                ListParameter("BSSID", parameter: wifi.bssid)
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
}
