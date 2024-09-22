import SwiftUI

fileprivate struct ListSpec: View {
    private let name: LocalizedStringKey
    private let icon: String
    private let spec: String
    
    init(_ name: LocalizedStringKey, icon: String, spec: String = "") {
        self.name = name
        self.icon = icon
        self.spec = spec
    }
    
    var body: some View {
        HStack {
            Label(name, systemImage: icon)
            
            Spacer()
            
            Text(spec)
        }
        .foregroundStyle(.foreground)
    }
}

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
            
            ListSpec("Device", icon: "info.circle", spec: device.deviceIdentifier)
            
            ListSpec("System", icon: "apple.terminal", spec: system.operatingSystem)
            
            ListSpec("Display", icon: "iphone", spec: display.diagonalSize)
            
            ListSpec("Processor", icon: "cpu", spec: processor.cpu)
            
            ListSpec("Memory", icon: "memorychip", spec: memory.totalRamAndDisk)
            
            ListSpec("Battery", icon: "battery.100percent.bolt", spec: battery.batteryLevel)
                .symbolRenderingMode(.multicolor)
            
            ListSpec("Network", icon: "network", spec: connectivity.type)
            
            ListSpec("Cameras", icon: "camera")
            
            ListSpec("Sensors", icon: "barometer")
            
            ListSpec("Accessibility", icon: "accessibility")
            
            Section {
                ListSpec("Tests", icon: "testtube.2")
            }
            
            Section {
                ListSpec("About", icon: "questionmark.square.dashed", spec: app.versionAndBuild)
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
