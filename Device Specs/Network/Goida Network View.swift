import ScrechKit

struct Goida_Network_View: View {
    private var network = NetworkVM()
    private var wifi = WifiVM()
    
    var body: some View {
        List {
            if let ipAddress = network.getIPAddress() {
                ListParameter("IP-address", parameter: ipAddress)
            }
            
            Section("Wi-Fi") {
                ListParameter("Connected to...", parameter: wifi.networkStatus)
                ListParameter("Name", parameter: wifi.ssid)
                ListParameter("Address", parameter: wifi.bssid)
            }
        }
        .navigationTitle("Network")
    }
}

#Preview {
    Goida_Network_View()
}
