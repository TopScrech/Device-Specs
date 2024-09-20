import SwiftUI

struct MagneticFieldView: View {
    @State private var vm = MagneticFieldViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            // Normal Magnetic Field Data
            GroupBox {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("X:")
                        
                        Spacer()
                        
                        Text(String(format: "%.2f µT", vm.magneticField.x))
                            .bold()
                    }
                    
                    HStack {
                        Text("Y:")
                        
                        Spacer()
                        
                        Text(String(format: "%.2f µT", vm.magneticField.y))
                            .bold()
                    }
                    
                    HStack {
                        Text("Z:")
                        
                        Spacer()
                        
                        Text(String(format: "%.2f µT", vm.magneticField.z))
                            .bold()
                    }
                }
                .padding()
            } label: {
                Text("Normal Data")
                    .headline()
            }
            .padding(.horizontal, 20)
            
            // Raw Magnetic Field Data
            GroupBox {
                if let raw = vm.rawMagneticField {
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Raw X:")
                            
                            Spacer()
                            
                            Text(String(format: "%.2f µT", raw.x))
                                .bold()
                        }
                        
                        HStack {
                            Text("Raw Y:")
                            
                            Spacer()
                            
                            Text(String(format: "%.2f µT", raw.y))
                                .bold()
                        }
                        
                        HStack {
                            Text("Raw Z:")
                            
                            Spacer()
                            
                            Text(String(format: "%.2f µT", raw.z))
                                .bold()
                        }
                    }
                    .padding()
                } else {
                    Text("Raw data not available.")
                        .padding()
                }
            } label: {
                Text("Raw Data")
                    .headline()
            }
            .padding([.leading, .trailing], 20)
            
            // Heading Accuracy
            GroupBox {
                VStack(alignment: .leading, spacing: 10) {
                    if let accuracy = vm.headingAccuracy {
                        HStack {
                            Text("Accuracy:")
                            
                            Spacer()
                            
                            Text("\(accuracy)°")
                                .bold()
                        }
                    } else {
                        Text("Accuracy not available.")
                            .padding()
                    }
                    
                    // Display authorization status or errors
                    switch vm.authorizationStatus {
                    case .authorizedAlways, .authorizedWhenInUse:
                        if let error = vm.locationError {
                            Text("Location Error: \(error.localizedDescription)")
                                .foregroundColor(.red)
                                .padding()
                        }
                        
                    case .denied, .restricted:
                        Text("Location access denied. Accuracy may be unavailable.")
                            .foregroundColor(.orange)
                            .padding()
                        
                    case .notDetermined:
                        Text("Requesting location access...")
                            .padding()
                        
                    @unknown default:
                        Text("Unknown location status.")
                            .padding()
                    }
                }
                .padding()
            } label: {
                Text("Heading Accuracy")
                    .headline()
            }
            .padding([.leading, .trailing], 20)
            
            Spacer()
        }
    }
}

#Preview {
    MagneticFieldView()
}
