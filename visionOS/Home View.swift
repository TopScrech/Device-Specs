import ScrechKit

struct HomeView: View {
    //    @Environment(NavState.self) private var navState
    
    var body: some View {
        List {
            ListLink("Device and system", icon: "info.circle") {
                DeviceView()
            }
            
            ListLink("Display", icon: "iphone") {
                DisplaySpecs()
            }
            
            ListLink("Memory", icon: "memorychip") {
                MemoryView()
            }
            
            //            ListLink("Camera", icon: "camera") {
            //                CameraSpecs()
            //            }
            
            ListLink("Battery", icon: "battery.100percent.bolt") {
                BatterySpecs()
            }
            .symbolRenderingMode(.multicolor)
            
            //            //            ListLink("Network", icon: "network") {
            //            //                NetworkView()
            //            //            }
            //
            //            ListLink("Sensors", icon: "barometer") {
            //                SensorsView()
            //            }
            //
            //            Section {
            //                Button("Tests") {
            //                    navState.navigate(.toTests)
            //                }
            //                .foregroundStyle(.foreground)
            //            }
        }
        .navigationTitle("Device Specs")
        .foregroundStyle(.foreground)
    }
}

#Preview {
    NavigationView {
        HomeView()
    }
}
