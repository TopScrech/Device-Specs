import SwiftUI

struct Volume: View {
    @State private var vm = VolumeVM()
    
    var body: some View {
        Group {
            if vm.isVolumeSectionVisible {
                Section("Volume") {
                    VolumeSlider()
                        .padding(.top, 5)
                        .listRowBackground(Color.clear)
                }
            }
        }
        .task {
            await vm.observeRouteChanges()
        }
    }
}

#Preview {
    List {
        Volume()
    }
    .darkSchemePreferred()
}
