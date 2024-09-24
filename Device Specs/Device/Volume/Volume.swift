import SwiftUI

struct Volume: View {
    var body: some View {
        Section("Volume") {
            VolumeSlider()
        }
    }
}

#Preview {
    List {
        Volume()
    }
}
