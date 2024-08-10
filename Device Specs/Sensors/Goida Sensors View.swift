import ScrechKit

struct Goida_Sensors_View: View {
    private var location = LocationVM()
    private var orientation = OrientationVM()
    private var altitude = AltitudeVM()
    private var pressure = PressureVM()
    private var activity = ActivityVM()
    
    var body: some View {
        List {
            Section("Location") {
                ListParameter("Latitude", parameter: String(location.latitude))
                ListParameter("Longitude", parameter: String(location.longitude))
                
                HStack {
                    Text("True heading")
                    
                    Spacer()
                    
                    Image(systemName: "arrow.up.circle")
                        .title3(.semibold)
                        .foregroundColor((location.trueHeading >= 355 || location.trueHeading <= 5) ? .green : .primary)
                        .rotationEffect(.degrees(location.trueHeading))
                    
                    Text(String(format: "%.1f", location.trueHeading) + "°")
                        .foregroundStyle(.secondary)
                }
            }
            
            Section("Rotation") {
                ListParameter("Roll", parameter: orientation.roll)
                ListParameter("Pitch", parameter: orientation.pitch)
                ListParameter("Yaw", parameter: orientation.yaw)
                ListParameter("Orientation", parameter: orientation.orientation)
            }
            
            Section("Acceleration") {
                ListParameter("X Axis", parameter: orientation.x)
                ListParameter("Y Axis", parameter: orientation.y)
                ListParameter("Z Axis", parameter: orientation.z)
            }
            
            Section("Altimeter") {
                ListParameter("Pressure", parameter: pressure.pressureKilo)
                ListParameter("Relative altitude", parameter: altitude.relativeAltitude)
                ListParameter("Absolute altitude", parameter: altitude.absoluteAltitude)
            }
            
            Section("Motion coprocessor") {
                ListParameter("Activity", parameter: activity.activity)
                ListParameter("Confidence", parameter: activity.confidence)
            }
        }
        .numericTransition()
        .navigationTitle("Sensors")
    }
}

#Preview {
    Goida_Sensors_View()
}
