import SwiftUI

struct DisplaySpecs: View {
    var body: some View {
        List {
            LabeledContent("Screen resolution", value: DisplayVM.resolution)
            LabeledContent("Refresh rate", value: DisplayVM.refreshRate)

        }
        .navigationTitle("Display")
    }
}

#Preview {
    NavigationStack {
        DisplaySpecs()
    }
    .darkSchemePreferred()
}
