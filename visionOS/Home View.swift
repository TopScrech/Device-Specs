import ScrechKit

struct HomeView: View {
    var body: some View {
        List {
            ListLink("Device and system", icon: "info.circle") {
                DeviceSpecs()
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
                NetworkSpecs()
            }
            
#if DEBUG
            ListLink("Sensors", icon: "barometer") {
                SensorsView()
            }
#endif
            
            ListLink("Accessibility", icon: "accessibility") {
                AccessibilityView()
            }
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
