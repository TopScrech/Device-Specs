import ScrechKit

struct HomeView: View {
    var body: some View {
        List {
            //            ListLink("Device and system", icon: "info.circle") {
            //                DeviceView()
            //            }
            //
            //            ListLink("Display", icon: "iphone") {
            //                DisplaySpecs()
            //            }
            
            ListLink("Processor", icon: "cpu") {
                ProcessorView()
            }
            
            //            ListLink("Memory", icon: "memorychip") {
            //                MemoryView()
            //            }
            
            ListLink("Battery", icon: "battery.100percent.bolt") {
                BatterySpecs()
            }
            .symbolRenderingMode(.multicolor)
            
            ListLink("Network", icon: "network") {
                NetworkView()
            }
            
            //            ListLink("Sensors", icon: "barometer") {
            //                SensorsView()
            //            }
            
            //            Section {
            //                Button("Tests") {
            //                    navState.navigate(.toTests)
            //                }
            //                .foregroundStyle(.foreground)
            //            }
        }
    }
}

#Preview {
    HomeView()
}
