import SwiftUI

struct DeviceWatchInfo: View {
    private var crownOrientation: String {
        switch WKInterfaceDevice.current().crownOrientation {
        case .left: "Left"
        case .right: "Right"
        default: "Unknown"
        }
    }
    
    private var wristLocation: String {
        switch WKInterfaceDevice.current().wristLocation {
        case .left: "Left"
        case .right: "Right"
        default: "Unknown"
        }
    }
    
    private var layoutDirection: String {
        switch WKInterfaceDevice.current().layoutDirection {
        case .leftToRight: "Left to right"
        case .rightToLeft: "Right to left"
        default: "Unknown"
        }
    }
    
    private let waterLockEnabled = WKInterfaceDevice.current().isWaterLockEnabled
    
    var body: some View {
        Section("Watch Specific") {
            LabeledContent("Crown orientation", value: crownOrientation)
            LabeledContent("Water lock", value: waterLockEnabled.yesOrNo())
            LabeledContent("Layout direction", value: layoutDirection)
            LabeledContent("Wrist location", value: wristLocation)
        }
    }
}

#Preview {
    List {
        DeviceWatchInfo()
    }
    .darkSchemePreferred()
}
