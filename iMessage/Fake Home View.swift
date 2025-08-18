import ScrechKit

struct FakeHomeView: View {
    @State private var navState = NavState()
    
    @State private var system = SystemVM()
    @State private var device = DeviceVM()
    @State private var display = DisplayVM()
    @State private var processor = ProcessorVM()
    @State private var memory = MemoryVM()
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
            
            ListParam("Device", icon: "info.circle", param: device.deviceIdentifier)
            
            ListParam("System", icon: "apple.terminal", param: system.operatingSystem)
            
            ListParam("Display", icon: "iphone", param: display.diagonalSize)
            
            ListParam("Processor", icon: "cpu", param: processor.cpuNameAndTechnology)
            
            ListParam("Memory", icon: "memorychip", param: memory.totalRamAndDisk)
            
            ListParam("Battery", icon: "battery.100percent.bolt", param: battery.batteryLevel)
                .symbolRenderingMode(.multicolor)
            
            ListParam("Network", icon: "network", param: connectivity.type)
            
            ListParam("Cameras", icon: "camera", param: camera.hasLidar)
            
            ListParam("Sensors", icon: "barometer")
            
            ListParam("Accessibility", icon: "accessibility")
            
            Section {
                ListParam("Tests", icon: "testtube.2")
            }
            
            Section {
                ListParam("About", icon: "questionmark.square.dashed", param: app.versionAndBuild)
            }
        }
        .fullScreenCover(isPresented: $isPresented) {
            SecondaryContainer()
                .environment(navState)
        }
    }
}

#Preview {
    NavigationView {
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
