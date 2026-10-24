import SwiftUI
import Device

struct IPhoneDetailView: View {
    let phone: DeviceDefinition

    var body: some View {
        List {
            ForEach(IPhoneSpecs.sections(for: phone), id: \.section) { group in
                Section(group.section.rawValue) {
                    ForEach(group.rows, id: \.title) {
                        LabeledContent($0.title, value: $0.value)
                    }
                }
            }
        }
        .navigationTitle(phone.name)
        .textSelection(.enabled)
    }
}
