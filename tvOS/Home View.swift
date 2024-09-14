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
            
            //            ListLink("Processor", icon: "cpu") {
            //                ProcessorView()
            //            }
            //
            //            ListLink("Memory", icon: "memorychip") {
            //                MemoryView()
            //            }
            
            //            ListLink("Network", icon: "network") {
            //                NetworkView()
            //            }
            //
            //            ListLink("Sensors", icon: "barometer") {
            //                SensorsView()
            //            }
            
            ListLink("Accessibility", icon: "accessibility") {
                AccessibilityView()
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
    NavigationView {
        HomeView()
    }
}
