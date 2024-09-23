import ScrechKit

struct NetworkSpecs: View {
    @State private var network = NetworkVM()
    @Environment(ConnectivityVM.self) private var connectivity
    
    var body: some View {
        List {
            ListParam("Public IP address", param: network.publicIp)
            
            ListParam("Network type", param: connectivity.type)
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
