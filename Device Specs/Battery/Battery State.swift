import SwiftUI

struct BatteryState: View {
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
    .darkSchemePreferred()
    .environment(BatteryVM())
}
