import ScrechKit

struct HomeView: View {
    @State private var battery = BatteryVM()
    @State private var processor = ProcessorVM()
    @State private var system = SystemVM()
    @State private var device = DeviceVM()
    @State private var memory = MemoryVM()
    @State private var connectivity = ConnectivityVM()
    @State private var app = AppVM()
    
    @State private var sheetChat = false
    
    var body: some View {
        List {
            Section {
                WarningSection()
                    .environment(BatteryVM())
            }
            
            SpecsLink("Device", icon: "info.circle", spec: DeviceVM.deviceIdentifier) {
                DeviceSpecs()
                    .environment(device)
            }
            
            SpecsLink("System", icon: "apple.terminal", spec: SystemVM.operatingSystem) {
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
                AccessibilitySpecs()
            }
            
            Section {
                SpecsLink("About", icon: "questionmark.square.dashed", spec: app.versionAndBuild) {
                    AboutView()
                        .environment(app)
                }
            }
            
            NavigationLink {
                AuthTest()
            } label: {
                HStack {
                    Label("Tests", systemImage: "testtube.2")
                    
                    Spacer()
                    
                    Image(systemName: "chevron.forward")
                        .bold()
                        .footnote()
                        .foregroundStyle(.tertiary)
                }
            }
        }
        .navigationTitle("Device Specs")
        .foregroundStyle(.foreground)
        .sheet($sheetChat) {
            if #available(visionOS 26, *) {
                NavigationStack {
                    ChatView()
                }
            }
        }
        .toolbar {
            if #available(visionOS 26, *) {
                ToolbarItem(placement: .topBarTrailing) {
                    SFButton("apple.intelligence") {
                        sheetChat = true
                    }
                    .symbolRenderingMode(.multicolor)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
    .darkSchemePreferred()
    .environment(BatteryVM())
    .environment(ProcessorVM())
    .environment(SystemVM())
    .environment(DeviceVM())
    .environment(MemoryVM())
    .environment(ConnectivityVM())
    .environment(AppVM())
}
