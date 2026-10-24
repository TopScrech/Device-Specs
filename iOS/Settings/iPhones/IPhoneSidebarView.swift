import SwiftUI

struct IPhoneSidebarView: View {
    @Environment(IPhoneListVM.self) private var model
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        @Bindable var model = model

        List(selection: $model.selectedPhone) {
            ForEach(IPhoneListVM.families, id: \.self) { family in
                Section {
                    ForEach(family, id: \.self) { phone in
                        NavigationLink(value: phone) {
                            IPhoneCardView(phone: phone)
                        }
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
        .navigationTitle(String("iPhones"))
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button(String("Done"), systemImage: "xmark") {
                    dismiss()
                }
            }

            ToolbarItem(placement: .primaryAction) {
                Menu {
                    Button("Name (always shown)", systemImage: "checkmark") {}
                        .disabled(true)

                    ForEach(IPhoneListVM.availableSpecs, id: \.self) { spec in
                        Button(spec, systemImage: model.selectedSpecs.contains(spec) ? "checkmark.circle.fill" : "circle") {
                            model.toggle(spec)
                        }
                    }
                } label: {
                    Label(String("Visible specs"), systemImage: "line.3.horizontal.decrease")
                }
                .menuActionDismissBehavior(.disabled)
            }
        }
    }
}
