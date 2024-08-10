import ScrechKit

struct HomeView: View {
    var body: some View {
        List {
            ListLink("Device and system", icon: "iphone") {
                GoidaDeviceView()
            }
            
            ListLink("Memory", icon: "memorychip") {
                Goida_Memory_View()
            }
            
            ListLink("Camera", icon: "camera") {
                GoidaCameraView()
            }
            
            ListLink("Battery", icon: "battery.100percent.bolt") {
                GoidaBatteryView()
            }
            
            ListLink("Network", icon: "network") {
                Goida_Network_View()
            }
            
            ListLink("Sensors", icon: "barometer") {
                Goida_Sensors_View()
            }
            
            Section {
                NavigationLink("Tests") {
                    GoidaTestList()
                }
            }
        }
        .navigationTitle("GOIDA24")
    }
}

#Preview {
    NavigationView {
        HomeView()
    }
}
