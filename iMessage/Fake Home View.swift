import ScrechKit

struct FakeHomeView: View {
    @State private var navState = NavState()
    
    @State private var system = SystemVM()
    @State private var device = DeviceVM()
    @State private var battery = BatteryVM()
    @State private var processor = ProcessorVM()
    @State private var memory = MemoryVM()
    @State private var display = DisplayVM()
    @State private var app = AppVM()
    @State private var connectivity = ConnectivityVM()
    
    @State private var isPresented = false
    
    var body: some View {
        List {
            Section {
                Button("Open in full screen") {
                    isPresented = true
                }
            }
            
            ListParam("Device", icon: "info.circle", param: device.deviceIdentifier)
            
            ListParam("System", icon: "apple.terminal", param: system.operatingSystem)
            
            ListParam("Display", icon: "iphone", param: display.diagonalSize)
            
            ListParam("Processor", icon: "cpu", param: processor.cpu)
            
            ListParam("Memory", icon: "memorychip", param: memory.totalRamAndDisk)
            
            ListParam("Battery", icon: "battery.100percent.bolt", param: battery.batteryLevel)
                .symbolRenderingMode(.multicolor)
            
            ListParam("Network", icon: "network", param: connectivity.type)
            
            ListParam("Cameras", icon: "camera")
            
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
    .environment(BatteryVM())
    .environment(ProcessorVM())
    .environment(DisplayVM())
    .environment(SystemVM())
    .environment(DeviceVM())
    .environment(MemoryVM())
    .environment(AppVM())
    .environment(ConnectivityVM())
}
