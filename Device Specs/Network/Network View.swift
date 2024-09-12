import ScrechKit

struct NetworkView: View {
    private var network = NetworkVM()
    private var wifi = WifiVM()
    
    var body: some View {
        List {
//            if let ipAddress = network.getIPAddress() {
            ListParameter("IP-address", parameter: network.address)
            ListParameter("Router", parameter: network.router)
//            }
            
            Section("Wi-Fi") {
                ListParameter("Connected to...", parameter: wifi.networkStatus)
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
