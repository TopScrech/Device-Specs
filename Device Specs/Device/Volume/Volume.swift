import SwiftUI

struct Volume: View {
    var body: some View {
        Section("Volume") {
            VolumeSlider()
                .padding(.top, 5)
                .listRowBackground(Color.clear)
        }
    }
}

#Preview {
    List {
        Volume()
    }
}
