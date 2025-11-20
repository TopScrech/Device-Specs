import SwiftUI

struct SensorsView: View {
    private var location = LocationVM()
    private var orientation = OrientationVM()
    private var altitude = AltitudeVM()
    
    var body: some View {
        List {
            Section("Location") {
                LabeledContent("Latitude", value: String(location.latitude))
                LabeledContent("Longitude", value: String(location.longitude))
            }
            
            Section("Rotation") {
                LabeledContent("Roll", value: orientation.roll)
                LabeledContent("Pitch", value: orientation.pitch)
                LabeledContent("Yaw", value: orientation.yaw)
            }
            
            Section("Acceleration") {
                LabeledContent("X Axis", value: orientation.x)
                LabeledContent("Y Axis", value: orientation.y)
                LabeledContent("Z Axis", value: orientation.z)
            }
            
            Section("Altimeter") {
                LabeledContent("Absolute altitude", value: altitude.absoluteAltitude)
            }
        }
        .navigationTitle("Sensors")
        .numericTransition()
    }
}

#Preview {
    NavigationStack {
        SensorsView()
    }
    .darkSchemePreferred()
}
