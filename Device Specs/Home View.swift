import ScrechKit

struct HomeView: View {
    @State private var battery = BatteryVM()
    
    @Environment(NavState.self) private var navState
    
    var body: some View {
        List {
            ListLink("Device and system", icon: "info.circle") {
                DeviceView()
            }
            
            ListLink("Display", icon: "iphone") {
                DisplaySpecs()
            }
            
            ListLink("Processor", icon: "cpu") {
                ProcessorView()
            }
            
            ListLink("Memory", icon: "memorychip") {
                MemoryView()
            }
            
            ListLink("Camera", icon: "camera") {
                CameraSpecs()
            }
            
            NavigationLink {
                BatterySpecs()
                    .environment(battery)
            } label: {
                HStack {
                    Label("Battery", systemImage: "battery.100percent.bolt")
                        .symbolRenderingMode(.multicolor)
                    
                    Spacer()
                    
                    Text(battery.batteryLevel)
                        .foregroundStyle(.secondary)
                }
            }
            
            ListLink("Network", icon: "network") {
                NetworkView()
            }
            
            ListLink("Sensors", icon: "barometer") {
                SensorsView()
            }
            
            ListLink("Accessibility", icon: "accessibility") {
                AccessibilityView()
            }
            
            Section {
                Button("Tests") {
                    navState.navigate(.toTests)
                }
                .foregroundStyle(.foreground)
            }
        }
        .navigationTitle("Device Specs")
        .refreshableTask {
            battery.fetchBatteryInfo()
        }
    }
}

#Preview {
    NavigationView {
        HomeView()
    }
}
