import SwiftUI
import Device

struct IPhoneListView: View {
    var body: some View {
        List {
            ForEach(Device.iPhones, id: \.self) { phone in
                Section(phone.name) {
                    ForEach(IPhoneSpecs.rows(for: phone), id: \.title) {
                        LabeledContent($0.title, value: $0.value)
                    }
                }
            }
        }
        .navigationTitle(String("iPhones"))
        .textSelection(.enabled)
    }
}
