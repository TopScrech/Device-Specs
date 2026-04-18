import ScrechKit

struct MinimizedHomeView: View {
    @State private var nav = NavState()
    
    @State private var system = SystemVM()
    @State private var device = DeviceVM()
    @State private var display = DisplayVM()
    @State private var cpu = ProcessorVM()
    @State private var ram = MemoryVM()
    @State private var battery = BatteryVM()
    @State private var connectivity = ConnectivityVM()
    @State private var camera = CameraVM()
    @State private var app = AppVM()
    
    @State private var isPresented = false
    
    var body: some View {
        List {
            Section {
                Button("Open in full screen to view all specs") {
                    isPresented = true
                }
            }
            
            LabeledContent("Device", icon: "info.circle", value: DeviceVM.deviceIdentifier)
            LabeledContent("System", icon: "apple.terminal", value: SystemVM.operatingSystem)
            LabeledContent("Display", icon: "iphone", value: display.diagonalSize)
            LabeledContent("Processor", icon: "cpu", value: cpu.cpuNameAndTechnology)
            LabeledContent("Memory", icon: "memorychip", value: ram.totalRamAndDisk)
            
            LabeledContent("Battery", icon: "battery.100percent.bolt", value: battery.batteryLevel)
                .symbolRenderingMode(.multicolor)
            
            LabeledContent("Network", icon: "network", value: connectivity.type)
            LabeledContent("Camera", icon: "camera", value: camera.hasLidarText)
            Label("Sensors", systemImage: "barometer")
            Label("Accessibility", systemImage: "accessibility")
            
            Section {
                Label("Tests", systemImage: "testtube.2")
            }
            
            Section {
                LabeledContent("About", icon: "questionmark.square.dashed", value: app.versionAndBuild)
            }
        }
        .fullScreenCover(isPresented: $isPresented) {
            SecondaryContainer()
                .environment(nav)
        }
    }
}

#Preview {
    NavigationStack {
        HomeView()
    }
    .darkSchemePreferred()
    .environment(DeviceVM())
    .environment(SystemVM())
    .environment(DisplayVM())
    .environment(BatteryVM())
    .environment(ProcessorVM())
    .environment(MemoryVM())
    .environment(ConnectivityVM())
    .environment(CameraVM())
    .environment(AppVM())
}
