import ScrechKit
import AutoUpdate
import OSLog

struct HomeView: View {
    @Environment(NavState.self) private var nav
    
    let assistantRequest: Int
    
    @State private var battery = BatteryVM()
    @State private var processor = ProcessorVM()
    @State private var display = DisplayVM()
    @State private var system = SystemVM()
    @State private var device = DeviceVM()
    @State private var memory = MemoryVM()
    @State private var connectivity = ConnectivityVM()
    @State private var camera = CameraVM()
    
    @State private var sheetChat = false
    @State private var alertUpdate = false
    @State private var updateChecker = AppStoreUpdateChecker(appID: 6624303981)
    
    private let url = URL(string: "https://fancontrol.dev?source=device-specs")!
    
    var body: some View {
        List {
            WarningSection()
                .environment(battery)
            
            SpecsLink("Device", icon: "info.circle", spec: DeviceVM.deviceIdentifier) {
                DeviceSpecs()
                    .environment(device)
            }
            .lineLimit(1)
            .minimumScaleFactor(0.5)
            
            SpecsLink("System", icon: "apple.terminal", spec: SystemVM.operatingSystem) {
                SystemSpecs()
                    .environment(system)
            }
            
            SpecsLink("Display", icon: "iphone", spec: DisplayVM.diagonalSize) {
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
            
            SpecsLink("Camera", icon: "camera", spec: camera.hasLidarText) {
                CameraSpecs()
                    .environment(camera)
            }
            
            SpecsLink("Accessibility", icon: "accessibility") {
                AccessibilitySpecs()
            }
            
            Section {
                Button {
                    nav.navigate(.toSensors)
                } label: {
                    HStack {
                        Label("Sensors", systemImage: "barometer")
                        
                        Spacer()
                        
                        Image(systemName: "chevron.forward")
                            .caption(.semibold)
                            .tertiary()
                    }
                }
                .foregroundStyle(.foreground)
                
                HomeViewTestLink()
            }
            
            AdView("FanControl", subtitle: "Keep Your Mac Cool and Quiet", url: url)
        }
        .listSectionSpacing(16)
        .navigationTitle(DeviceVM.deviceIdentifier)
        .scrollIndicators(.never)
        .appStoreOverlay($alertUpdate, id: updateChecker.configuration.appID)
        .task {
            if await updateChecker.checkForUpdates()?.updateAvailable == true {
                alertUpdate = true
            }
        }
        .task {
            for await _ in NotificationCenter.default.notifications(named: UIApplication.didBecomeActiveNotification) {
                battery.fetchBatteryInfo()
            }
        }
        .onChange(of: assistantRequest) { oldValue, newValue in
            guard newValue > oldValue else {
                return
            }
            
            if #available(iOS 26, *) {
                sheetChat = true
            }
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
                    SFButton("siri") {
                        sheetChat = true
                    }
                    .symbolRenderingMode(.multicolor)
                    .keyboardShortcut("a")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        HomeView(assistantRequest: 0)
    }
    .darkSchemePreferred()
    .environment(BatteryVM())
    .environment(ProcessorVM())
    .environment(DisplayVM())
    .environment(SystemVM())
    .environment(DeviceVM())
    .environment(MemoryVM())
    .environment(ConnectivityVM())
    .environment(CameraVM())
}
