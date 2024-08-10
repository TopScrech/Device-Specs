import ScrechKit

struct HomeView: View {
    var body: some View {
        List {
            ListLink("Device and system", icon: "iphone") {
                DeviceView()
            }
            
            ListLink("Display", icon: "iphone") {
                DisplaySpecs()
            }
            
            ListLink("Memory", icon: "memorychip") {
                MemoryView()
            }
            
            ListLink("Camera", icon: "camera") {
                CameraSpecs()
            }
            
            ListLink("Battery", icon: "battery.100percent.bolt") {
                BatterySpecs()
            }
            
            //            ListLink("Network", icon: "network") {
            //                NetworkView()
            //            }
            
            ListLink("Sensors", icon: "barometer") {
                SensorsView()
            }
            
            Section {
                NavigationLink("Tests") {
                    TestList()
                }
            }
        }
        .navigationTitle("Device Specs")
    }
}

#Preview {
    NavigationView {
        HomeView()
    }
}
