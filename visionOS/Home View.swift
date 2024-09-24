import ScrechKit

struct HomeView: View {
    @State private var battery = BatteryVM()
    @State private var processor = ProcessorVM()
    @State private var system = SystemVM()
    @State private var device = DeviceVM()
    @State private var memory = MemoryVM()
    @State private var connectivity = ConnectivityVM()
    @State private var app = AppVM()
    
    var body: some View {
        List {
            SpecsLink("Device", icon: "info.circle", spec: device.deviceIdentifier) {
                DeviceSpecs()
                    .environment(device)
            }
            
            SpecsLink("System", icon: "apple.terminal", spec: system.operatingSystem) {
                SystemSpecs()
                    .environment(system)
            }
            
            SpecsLink("Display", icon: "iphone") {
                DisplaySpecs()
            }
            
            SpecsLink("Processor", icon: "cpu", spec: processor.cpuNameAndTechnology) {
                ProcessorSpecs()
                    .environment(processor)
            }
            
            SpecsLink("Memory", icon: "memorychip", spec: memory.totalRamAndDisk) {
                MemorySpecs()
                    .environment(memory)
            }
            
            SpecsLink("Battery", icon: "battery.100percent.bolt", spec: battery.batteryLevel) {
                BatterySpecs()
                    .environment(battery)
            }
            .symbolRenderingMode(.multicolor)
            
            SpecsLink("Network", icon: "network", spec: connectivity.type) {
                NetworkSpecs()
                    .environment(connectivity)
            }
#if DEBUG
            SpecsLink("Sensors", icon: "barometer") {
                SensorsView()
            }
#endif
            SpecsLink("Accessibility", icon: "accessibility") {
                AccessibilityView()
            }
            
            Section {
                SpecsLink("About", icon: "questionmark.square.dashed", spec: app.versionAndBuild) {
                    AppSpecs()
                        .environment(app)
                }
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
    .environment(BatteryVM())
    .environment(ProcessorVM())
    .environment(SystemVM())
    .environment(DeviceVM())
    .environment(MemoryVM())
    .environment(ConnectivityVM())
    .environment(AppVM())
}
