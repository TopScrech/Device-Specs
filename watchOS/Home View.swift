import ScrechKit

struct HomeView: View {
    var body: some View {
        List {
            ListLink("Device and system", icon: "info.circle") {
                DeviceView()
            }
            
            ListLink("Display", icon: "iphone") {
                DisplaySpecs()
            }
            
            ListLink("Processor", icon: "cpu") {
                ProcessorSpecs()
            }
            
            ListLink("Memory", icon: "memorychip") {
                MemoryView()
            }
            
            ListLink("Battery", icon: "battery.100percent.bolt") {
                BatterySpecs()
            }
            .symbolRenderingMode(.multicolor)
            
            ListLink("Network", icon: "network") {
                NetworkView()
            }
            
            ListLink("Sensors", icon: "barometer") {
                SensorsView()
            }
            
            Section {
                NavigationLink("Tests") {
                    TestList()
                }
                .foregroundStyle(.foreground)
            }
        }
        .navigationTitle("Device Specs")
    }
}

#Preview {
    HomeView()
}
