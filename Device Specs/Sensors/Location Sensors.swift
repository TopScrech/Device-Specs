import ScrechKit

struct LocationSensors: View {
    @State private var location = LocationVM()
    
    var body: some View {
        Section("Location") {
            ListParam("Latitude", param: String(format: "%.6f", location.latitude))
            ListParam("Longitude", param: String(format: "%.6f", location.longitude))
            
            HStack {
                Text("True heading")
                
                Spacer()
                
                let trueHeading = location.trueHeading
                
                Image(systemName: "arrow.up.circle")
                    .semibold()
                    .title3()
                    .foregroundColor((trueHeading >= 355 || trueHeading <= 5) ? .green : .primary)
                    .rotationEffect(.degrees(trueHeading))
                
                Text(String(format: "%.1f", trueHeading) + "°")
                    .secondary()
            }
            
            HStack {
                Text("Magnetic heading")
                
                Spacer()
                
                let magneticHeading = location.magneticHeading
                
                Image(systemName: "arrow.up.circle")
                    .semibold()
                    .title3()
                    .foregroundColor((magneticHeading >= 355 || magneticHeading <= 5) ? .green : .primary)
                    .rotationEffect(.degrees(magneticHeading))
                
                Text(String(format: "%.1f", magneticHeading) + "°")
                    .secondary()
            }
            
            ListParam("Heading accuracy", param: String(format: "%.2f", location.headingAccuracy) + "°")
        }
    }
}

#Preview {
    List {
        LocationSensors()
    }
    .darkSchemePreferred()
}
