import ScrechKit

struct NetworkSpecs: View {
    @State private var network = NetworkVM()
    @Environment(ConnectivityVM.self) private var connectivity
    
    var body: some View {
        List {
            ListParameter("Public IP address", parameter: network.publicIp)
            
            ListParameter("Network type", parameter: connectivity.type)
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
