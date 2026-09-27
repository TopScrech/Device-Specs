import ScrechKit
import AutoUpdate

fileprivate let identifier: String = {
    var systemInfo = utsname()
    uname(&systemInfo)
    
    let mirror = Mirror(reflecting: systemInfo.machine)
    
    let identifier = mirror.children.reduce("") { identifier, element in
        guard let value = element.value as? Int8, value != 0 else {
            return identifier
        }
        
        return identifier + String(UnicodeScalar(UInt8(value)))
    }
    
    return identifier
}()

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
    @State private var showSettings = false
    @State private var alertUpdate = false
    @State private var updateChecker = AppStoreUpdateChecker(appID: 6624303981)
    
    private let url = URL(string: "https://fancontrol.dev?source=device-specs")!
    
    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]
    
    private var networkType: String {
        connectivity.type.replacing("\n", with: " + ")
    }
    
    private var networkDetail: String {
        connectivity.ssid ?? connectivity.linkQuality ?? connectivity.pathStatus ?? ""
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 12) {
                WarningSection()
                    .environment(battery)
                
                AdView("FanControl", subtitle: "Keep Your Mac Cool and Quiet", url: url)
                
                HomeViewCard("Device", icon: "info.circle", value: DeviceVM.deviceIdentifier, detail: Text(identifier)) {
                    DeviceSpecs()
                        .environment(device)
                }
                
                LazyVGrid(columns: columns, spacing: 12) {
                    HomeViewCard("System", icon: "apple.terminal", value: SystemVM.operatingSystem, detail: Text("\(Text("Build")) \(SystemVM.buildNumber)")) {
                        SystemSpecs()
                            .environment(system)
                    }
                    
                    HomeViewCard("Display", icon: "iphone", value: DisplayVM.diagonalSize, detail: Text(verbatim: "\(DisplayVM.refreshRate) Hz")) {
                        DisplaySpecs()
                            .environment(display)
                    }
                    
                    HomeViewCard("Processor", icon: "cpu", value: ProcessorVM.cpuName, detail: Text(verbatim: ProcessorVM.techNode)) {
                        ProcessorSpecs()
                            .environment(processor)
                    }
                    
                    HomeViewBatteryCard()
                        .environment(battery)
                    
                    HomeViewCard("Storage", icon: "internaldrive", value: memory.totalDisk, detail: Text("\(Text("Free")) \(memory.freeDisk)")) {
                        MemorySpecs()
                            .environment(memory)
                    }
                    
                    HomeViewCard("RAM", icon: "memorychip", value: memory.totalRAM, detail: Text("\(Text("Used")) \(memory.usedRAM)")) {
                        MemorySpecs()
                            .environment(memory)
                    }
                    
                    HomeViewCard("Network", icon: "network", value: networkType, detail: Text(verbatim: networkDetail)) {
                        NetworkSpecs()
                            .environment(connectivity)
                    }
                    
                    HomeViewCard("Camera", icon: "camera", value: camera.hasLidarText, detail: Text(verbatim: " ")) {
                        CameraSpecs()
                            .environment(camera)
                    }
                }
                
                VStack(spacing: 0) {
                    HomeRow("Accessibility", icon: "accessibility") {
                        AccessibilitySpecs()
                    }
                    
                    Divider()
                        .padding(.leading, 50)
                    
                    Button {
                        nav.navigate(.toSensors)
                    } label: {
                        HomeRowLabel("Sensors", icon: "barometer")
                    }
                    .buttonStyle(.plain)
                    
                    Divider()
                        .padding(.leading, 50)
                    
                    Button {
                        nav.navigate(.toTests)
                    } label: {
                        HomeRowLabel("Tests", icon: "testtube.2")
                    }
                    .buttonStyle(.plain)
                }
                .homeSurface()
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle(DeviceVM.deviceIdentifier)
        .scrollIndicators(.never)
        .appStoreOverlay($alertUpdate, id: updateChecker.configuration.appID)
        .task {
            memory.getDiskInfo()
        }
        .task {
            if await updateChecker.checkForUpdates()?.updateAvailable == true {
                alertUpdate = true
            }
        }
        .task {
            for await _ in NotificationCenter.default.notifications(named: UIApplication.didBecomeActiveNotification) {
                battery.fetchBatteryInfo()
                memory.getMemoryUsage()
                memory.getDiskInfo()
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
        .navigationDestination(isPresented: $showSettings) {
            SettingsView()
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
                SFButton("gear") {
                    showSettings = true
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
    .environment(NavState())
    .environment(BatteryVM())
    .environment(ProcessorVM())
    .environment(DisplayVM())
    .environment(SystemVM())
    .environment(DeviceVM())
    .environment(MemoryVM())
    .environment(ConnectivityVM())
    .environment(CameraVM())
}
