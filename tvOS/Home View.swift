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
            
            ListLink("Network", icon: "network") {
                NetworkSpecs()
            }
            
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
