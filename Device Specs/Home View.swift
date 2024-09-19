import ScrechKit

struct HomeView: View {
    @State private var battery = BatteryVM()
    @State private var processor = ProcessorVM()
    @State private var display = DisplayVM()
    @State private var system = SystemVM()
    @State private var device = DeviceVM()
    @State private var memory = MemoryVM()
    
    @Environment(NavState.self) private var navState
    
    var body: some View {
        List {
            NavigationLink {
                DeviceSpecs()
                    .environment(device)
            } label: {
                HStack {
                    Label("Device", systemImage: "info.circle")
                        .foregroundStyle(.foreground)
                    
                    Spacer()
                    
                    Text(device.deviceIdentifier)
                        .foregroundStyle(.secondary)
                }
            }
            
            NavigationLink {
                SystemSpecs()
                    .environment(system)
            } label: {
                HStack {
                    Label("System", systemImage: "apple.terminal")
                        .foregroundStyle(.foreground)
                    
                    Spacer()
                    
                    Text(system.operatingSystem)
                        .foregroundStyle(.secondary)
                }
            }
            
            NavigationLink {
                DisplaySpecs()
                    .environment(display)
            } label: {
                HStack {
                    Label("Display", systemImage: "iphone")
                        .foregroundStyle(.foreground)
                    
                    Spacer()
                    
                    Text(display.diagonalSize)
                        .foregroundStyle(.secondary)
                }
            }
            
#warning("Display on other platforms")
            
            NavigationLink {
                ProcessorSpecs()
                    .environment(processor)
            } label: {
                HStack {
                    Label("Processor", systemImage: "cpu")
                        .foregroundStyle(.foreground)
                    
                    Spacer()
                    
                    Text(processor.cpu)
                        .foregroundStyle(.secondary)
                }
            }
            
            NavigationLink {
                MemorySpecs()
                    .environment(memory)
            } label: {
                HStack {
                    Label("Memory", systemImage: "memorychip")
                        .foregroundStyle(.foreground)
                    
                    Spacer()
                    
                    Text(memory.totalRamAndDisk)
                        .foregroundStyle(.secondary)
                }
            }
            
            ListLink("Cameras", icon: "camera") {
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
                NetworkSpecs()
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
    }
}

#Preview {
    NavigationView {
        HomeView()
    }
    .environment(BatteryVM())
    .environment(ProcessorVM())
    .environment(DisplayVM())
    .environment(SystemVM())
    .environment(DeviceVM())
    .environment(MemoryVM())
    .environment(NavState())
}
