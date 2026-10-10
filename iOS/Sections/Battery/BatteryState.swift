import SwiftUI

struct BatteryState: View {
#if os(iOS)
    @ObservedObject private var store = ValueStore.shared
#endif

    @Environment(BatteryVM.self) private var vm
    
    var body: some View {
        HStack {
            Text("Battery state")
            
            Spacer()
            
            Text(vm.batteryState)
                .secondary()
            
            if vm.batteryState == "Charging" {
                Image(systemName: "bolt.fill")
                    .footnote()
            }
        }
    }
}

#Preview {
    List {
        BatteryState()
    }
    .environment(BatteryVM())
    .darkSchemePreferred()
}
