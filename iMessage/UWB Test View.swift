import ScrechKit

struct UWBTestView: View {
    @State private var vm = NearbyVM()
    
    var body: some View {
        @Bindable var binding = vm
        
        VStack(spacing: 20) {
            if vm.distance.isEmpty {
                Text("Open this app section on another UWB-capable device")
            }
            
            Text(vm.distance)
                .bold()
                .title()
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
                    .foregroundStyle(
                        vm.currentDistanceDirectionState == .unknown ||
                        vm.currentDistanceDirectionState == .outOfFOV ? .red : .primary
                    )
                
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
                    .foregroundStyle(
                        vm.currentDistanceDirectionState == .unknown ||
                        vm.currentDistanceDirectionState == .outOfFOV ? .red : .primary
                    )
            }
            
            Text(vm.monkeyLabel)
                .opacity(1)
                .fontSize(64)
                .rotationEffect(.degrees(vm.monkeyRotationAngle * 90))
        }
        .padding()
        .alert(vm.alertTitle, isPresented: $binding.showAlert) {
            Button("Go to Settings") {
                openSettings()
            }
            
            Button("Cancel") {}
        } message: {
            Text(vm.alertMessage)
        }
    }
}

#Preview {
    UWBTestView()
}
