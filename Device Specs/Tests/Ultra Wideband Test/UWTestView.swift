import SwiftUI

struct UWTestView: View {
    private var vm = NearbyVM()
    
    var body: some View {
        @Bindable var binding = vm
        
        VStack(spacing: 20) {
            Text(vm.distance)
                .title(.bold)
                .animation(.easeIn, value: vm.distance)
                .numericTransition()
            
            Text(vm.connectedDeviceName)
            
            //            Text(model.status)
            
            HStack {
                Image(systemName: "arrow.turn.up.left")
                    .foregroundStyle(vm.azimuthText.contains("-") ? .primary : .secondary)
                
                Text(vm.azimuthText)
                    .monospaced()
                    .padding(.horizontal, 5)
                    .foregroundStyle(vm.currentDistanceDirectionState == .unknown ||
                                     vm.currentDistanceDirectionState == .outOfFOV ? .red : .primary)
                
                Image(systemName: "arrow.turn.up.right")
                    .foregroundStyle(vm.azimuthText.contains("-") ? .secondary : .primary)
            }
            
            HStack {
                if vm.elevationText.contains("-") {
                    Image(systemName: "arrow.down")
                } else {
                    Image(systemName: "arrow.up")
                }
                
                Text(vm.elevationText)
                    .monospaced()
                    .foregroundStyle(vm.currentDistanceDirectionState == .unknown ||
                                     vm.currentDistanceDirectionState == .outOfFOV ? .red : .primary)
            }
            
            //            Text("\(model.monkeyRotationAngle)")
            
            Text(vm.monkeyLabel)
                .opacity(1)
                .fontSize(64)
                .rotationEffect(.degrees(vm.monkeyRotationAngle * 90))
        }
        .padding()
        .alert(vm.alertTitle, isPresented: $binding.showAlert) {
            Button("Go to Settings") {
                if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
                }
            }
            
            Button("Cancel") {}
        } message: {
            Text(vm.alertMessage)
        }
    }
}

#Preview {
    UWTestView()
}
