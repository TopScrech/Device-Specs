import SwiftUI

struct SensorsSpecs: View {
    @State private var orientation = OrientationVM()
    @State private var altitude = AltitudeVM()
    @State private var pressure = PressureVM()
    @State private var activity = ActivityVM()
    @State private var proximity = ProximityVM()
    
    var body: some View {
        List {
            LabeledContent("Proximity sensor triggered", value: proximity.isDeviceCloseToUser ? "Yes" : "No")
            
            LocationSensors()
            
            Section("Rotation") {
                LabeledContent("Roll", value: orientation.roll)
                LabeledContent("Pitch", value: orientation.pitch)
                LabeledContent("Yaw", value: orientation.yaw)
                LabeledContent("Orientation", value: orientation.orientation)
            }
            
            Section("Acceleration") {
                LabeledContent("X Axis", value: orientation.x)
                LabeledContent("Y Axis", value: orientation.y)
                LabeledContent("Z Axis", value: orientation.z)
            }
            
            Section("Altimeter") {
                if let pressure = pressure.pressureKilo {
                    LabeledContent("Pressure", value: pressure)
                }
                
                LabeledContent("Relative altitude", value: altitude.relativeAltitude)
                LabeledContent("Absolute altitude", value: altitude.absoluteAltitude)
            }
            
            MagneticFieldData()
            
            Section("Motion coprocessor") {
                LabeledContent("Activity", value: activity.activity)
                LabeledContent("Confidence", value: activity.confidence)
            }
        }
        .navigationTitle("Sensors")
        .monospacedDigit()
        .scrollIndicators(.never)
    }
}

#Preview {
    NavigationStack {
        SensorsSpecs()
    }
    .darkSchemePreferred()
}
