import SwiftUI

struct BatteryLevel: View {
    @Environment(BatteryVM.self) private var vm
    
    var body: some View {
        HStack {
            Text("Battery level")
            
            Spacer()
            
            VStack {
                Text(vm.batteryLevel)
                    .foregroundStyle(.secondary)
                    .animation(.default, value: vm.batteryLevel)
                
                Image(systemName: vm.icon)
                    .title()
                    .foregroundColor(vm.color)
                    .symbolRenderingMode(vm.batteryState == "Full" ? .multicolor : .hierarchical)
                    .animation(.default, value: vm.icon)
            }
        }
    }
}

#Preview {
    BatteryLevel()
        .environment(BatteryVM())
}
