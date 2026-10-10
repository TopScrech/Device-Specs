import SwiftUI

struct BatteryLevel: View {
#if os(iOS)
    @ObservedObject private var store = ValueStore.shared
#endif

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
    List {
        BatteryLevel()
    }
    .environment(BatteryVM())
    .darkSchemePreferred()
}
