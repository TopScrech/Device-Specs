import SwiftUI

struct SensorsView: View {
    private var orientation = OrientationVM()
    private var altitude = AltitudeVM()
    private var pressure = PressureVM()
    private var activity = ActivityVM()
    
    var body: some View {
        List {
            LocationSensors()
            
            Section("Rotation") {
                LabeledContent("Roll", value: orientation.roll)
                LabeledContent("Pitch", value: orientation.pitch)
                LabeledContent("Yaw", value: orientation.yaw)
#if os(iOS)
                LabeledContent("Orientation", value: orientation.orientation)
#endif
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
    }
}

#Preview {
    NavigationStack {
        SensorsView()
    }
    .darkSchemePreferred()
}
