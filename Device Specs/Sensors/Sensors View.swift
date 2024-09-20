import ScrechKit

struct SensorsView: View {
    @State private var location = LocationVM()
    @State private var orientation = OrientationVM()
    @State private var altitude = AltitudeVM()
    @State private var pressure = PressureVM()
    @State private var activity = ActivityVM()
    
    var body: some View {
        List {
            Section("Location") {
                ListParameter("Latitude", parameter: String(location.latitude))
                ListParameter("Longitude", parameter: String(location.longitude))
                
                HStack {
                    Text("True heading")
                    
                    Spacer()
                    
                    let trueHeading = location.trueHeading
                    
                    Image(systemName: "arrow.up.circle")
                        .title3(.semibold)
                        .foregroundColor((trueHeading >= 355 || trueHeading <= 5) ? .green : .primary)
                        .rotationEffect(.degrees(trueHeading))
                    
                    Text(String(format: "%.1f", trueHeading) + "°")
                        .foregroundStyle(.secondary)
                }
                
                HStack {
                    Text("Magnetic heading")
                    
                    Spacer()
                    
                    let magneticHeading = location.magneticHeading
                    
                    Image(systemName: "arrow.up.circle")
                        .title3(.semibold)
                        .foregroundColor((magneticHeading >= 355 || magneticHeading <= 5) ? .green : .primary)
                        .rotationEffect(.degrees(magneticHeading))
                    
                    Text(String(format: "%.1f", magneticHeading) + "°")
                        .foregroundStyle(.secondary)
                }
                
                ListParameter("Heading accuracy", parameter: String(location.headingAccuracy) + "°")
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
            
            Section("Magnetic field") {
                MagneticFieldData()
            }
            
            Section("Motion coprocessor") {
                ListParameter("Activity", parameter: activity.activity)
                ListParameter("Confidence", parameter: activity.confidence)
            }
        }
        .navigationTitle("Sensors")
        .numericTransition()
        .scrollIndicators(.never)
    }
}

#Preview {
    SensorsView()
}
