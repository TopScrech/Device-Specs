import ScrechKit

struct NetworkSpecs: View {
    @State private var network = NetworkVM()
    @State private var wifi = WifiVM()
    
    var body: some View {
        List {
            ListParameter("Public IP address", parameter: network.publicIp)
            
            ListParameter("Network type", parameter: wifi.networkStatus)
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
