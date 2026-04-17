import ScrechKit

struct HomeView: View {
    @State private var battery = BatteryVM()
    @State private var processor = ProcessorVM()
    @State private var display = DisplayVM()
    @State private var system = SystemVM()
    @State private var device = DeviceVM()
    @State private var memory = MemoryVM()
    @State private var app = AppVM()
    
    var body: some View {
        List {
            SpecsLink("Device", icon: "info.circle", spec: device.deviceIdentifier) {
                DeviceSpecs()
                    .environment(device)
            }
            
            SpecsLink("System", icon: "apple.terminal", spec: SystemVM.operatingSystem) {
                SystemSpecs()
                    .environment(system)
            }
            
            SpecsLink("Display", icon: "iphone", spec: display.diagonalSize) {
                DisplaySpecs()
                    .environment(display)
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
            
            SpecsLink("Network", icon: "network") {
                NetworkSpecs()
            }
            
            SpecsLink("Sensors", icon: "barometer") {
                SensorsView()
            }
            
            Section {
                SpecsLink("Tests", icon: "testtube.2") {
                    TestList()
                }
            }
            
            Section {
                SpecsLink("About", icon: "questionmark.square.dashed", spec: app.versionAndBuild) {
                    AboutView()
                        .environment(app)
                }
            }
        }
        .navigationTitle("Device Specs")
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
    .darkSchemePreferred()
    .environment(BatteryVM())
    .environment(ProcessorVM())
    .environment(DisplayVM())
    .environment(SystemVM())
    .environment(DeviceVM())
    .environment(MemoryVM())
    .environment(AppVM())
}
