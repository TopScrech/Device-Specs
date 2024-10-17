import SwiftUI

struct RecordList: View {
//    @Environment(HealthVM.self) private var vm
    
    private let records: [HealthRecord]
    
    init(_ records: [HealthRecord]) {
        self.records = records
    }
    
    var body: some View {
        List {
            if records.isEmpty {
                ContentUnavailableView("No records", systemImage: "hammer", description: Text("There're no records to show"))
            }
            
            ForEach(records) { record in
                Text(record.value)
            }
        }
    }
}

#Preview {
    RecordList([])
//        .environment(HealthVM())
}
