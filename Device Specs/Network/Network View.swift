import ScrechKit

struct NetworkView: View {
    @State private var network = NetworkVM()
    @State private var wifi = WifiVM()
    
    var body: some View {
        List {
            ListParameter("Public IP address", parameter: network.publicIp)
            
            ListParameter("Network interface", parameter: network.networkinterface)
            
#warning("Router differs from settings")
            ListParameter("Router", parameter: network.router)
            
            ListParameter("Subnet Mask", parameter: network.subnetMask)
            
            Section {
                ListParameter("Network type", parameter: wifi.networkStatus)
                ListParameter("Name", parameter: wifi.ssid)
                ListParameter("Address", parameter: wifi.bssid)
            }
        }
        .navigationTitle("Network")
        .refreshableTask {
            network.getIPAddresses()
        }
    }
}

#Preview {
    NetworkView()
}
