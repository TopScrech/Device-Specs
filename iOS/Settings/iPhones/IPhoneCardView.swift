import SwiftUI
import Device

struct IPhoneCardView: View {
    @Environment(IPhoneListVM.self) private var model

    let phone: DeviceDefinition

    var body: some View {
        VStack(alignment: .leading) {
            Text(phone.name)
                .font(.headline)

            ForEach(model.visibleRows(for: phone), id: \.title) {
                LabeledContent($0.title, value: $0.value)
                    .font(.subheadline)
            }
        }
    }
}
