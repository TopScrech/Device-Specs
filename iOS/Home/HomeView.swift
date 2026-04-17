import ScrechKit

struct HomeView: View {
    @Environment(NavState.self) private var nav
    
    @State private var battery = BatteryVM()
    @State private var processor = ProcessorVM()
    @State private var display = DisplayVM()
    @State private var system = SystemVM()
    @State private var device = DeviceVM()
    @State private var memory = MemoryVM()
    @State private var app = AppVM()
    @State private var connectivity = ConnectivityVM()
    @State private var camera = CameraVM()
    
    @State private var sheetChat = false
    
    var body: some View {
        List {
            WarningSection()
                .environment(battery)
            
            SpecsLink("Device", icon: "info.circle", spec: device.deviceIdentifier) {
                DeviceSpecs()
                    .environment(device)
            }
            .lineLimit(1)
            .minimumScaleFactor(0.5)
            
            SpecsLink("System", icon: "apple.terminal", spec: system.operatingSystem) {
                SystemSpecs()
                    .environment(system)
            }
            
            SpecsLink("Display", icon: "iphone", spec: display.diagonalSize) {
                DisplaySpecs()
                    .environment(display)
            }
            
            SpecsLink("Processor", icon: "cpu", spec: ProcessorVM.cpuName) {
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
            
            SpecsLink("Camera", icon: "camera", spec: camera.hasLidar) {
                CameraSpecs()
                    .environment(camera)
            }
            
            Button("Sensors", systemImage: "barometer") {
                nav.navigate(.toSensors)
            }
            .foregroundStyle(.foreground)
            
            SpecsLink("Accessibility", icon: "accessibility") {
                AccessibilitySpecs()
            }
            
            HomeViewTestLink()
            
            Section {
                SpecsLink("About", icon: "questionmark.square.dashed", spec: "v" + app.version) {
                    AboutView()
                        .environment(app)
                }
            }
        }
        .navigationTitle(device.deviceIdentifier)
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
            battery.fetchBatteryInfo()
        }
        .sheet($sheetChat) {
            if #available(iOS 26, *) {
                NavigationStack {
                    ChatView()
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                NavigationLink(destination: SettingsView()) {
                    Image(systemName: "gear")
                }
                .keyboardShortcut("s")
            }
            
            if #available(iOS 26, *) {
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
    .environment(DisplayVM())
    .environment(SystemVM())
    .environment(DeviceVM())
    .environment(MemoryVM())
    .environment(AppVM())
    .environment(ConnectivityVM())
    .environment(CameraVM())
}
