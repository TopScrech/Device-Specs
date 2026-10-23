import SwiftUI
import Device

struct DisplaySpecs: View {
    var body: some View {
        List {
            if let ppi = Device.current.display?.ppi.description {
                LabeledContent("PPI", value: ppi)
            }

            LabeledContent("Brightness", value: "Unavailable")
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
