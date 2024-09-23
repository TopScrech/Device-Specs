import SwiftUI

struct BatteryState: View {
    @Environment(BatteryVM.self) private var vm
    
    var body: some View {
        HStack {
            Text("Battery state")
            
            Spacer()
            
            Text(vm.batteryState)
                .foregroundStyle(.secondary)
                .animation(.default, value: vm.batteryState)
            
            if vm.batteryState == "Charging" {
                Image(systemName: "bolt.fill")
                    .footnote()
                    .animation(.default, value: vm.batteryState)
                    .transition(.identity)
            }
        }
    }
}

#Preview {
    BatteryState()
        .environment(BatteryVM())
}
