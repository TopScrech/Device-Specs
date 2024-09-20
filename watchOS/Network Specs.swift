import ScrechKit

struct NetworkSpecs: View {
    @State private var network = NetworkVM()
    @State private var connectivity = ConnectivityVM()
    
    var body: some View {
        List {
            ListParameter("Public IP address", parameter: network.publicIp)
            
            ListParameter("Network interface", parameter: network.networkinterface)
            
#warning("Router differs from settings")
            ListParameter("Router", parameter: network.router)
            
            ListParameter("Subnet mask", parameter: network.subnetMask)
            
            Section {
                ListParameter("Network type", parameter: connectivity.type)
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
