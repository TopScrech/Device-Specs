import SwiftUI

struct HealthCategoryLink: View {
    private let name: LocalizedStringKey
    private let icon: String
    private let records: [HealthRecord]
    
    init(_ name: LocalizedStringKey, icon: String, records: [HealthRecord]) {
        self.name = name
        self.icon = icon
        self.records = records
    }
    
    var body: some View {
        NavigationLink {
            RecordList(records)
        } label: {
            Label {
                Text(name)
                    .semibold()
                    .padding(.leading, 5)
            } icon: {
                Image(systemName: icon)
                    .title2()
            }
        }
        .padding(.vertical, 5)
    }
}

#Preview {
    List {
        HealthCategoryLink("Preview", icon: "hammer.fill", records: [])
    }
}
