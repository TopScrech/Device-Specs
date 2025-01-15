import SwiftUI

struct BatteryLevel: View {
    @Environment(BatteryVM.self) private var vm
    
    var body: some View {
        HStack {
            Text("Battery level")
            
            Spacer()
            
            VStack {
                Text(vm.batteryLevel)
                    .secondary()
                
                Image(systemName: vm.icon)
                    .title()
                    .foregroundColor(vm.color)
                    .symbolRenderingMode(vm.batteryState == "Full" ? .multicolor : .hierarchical)
            }
        }
    }
}

#Preview {
    BatteryLevel()
        .environment(BatteryVM())
}
