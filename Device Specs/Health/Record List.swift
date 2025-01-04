//import SwiftUI
//
//struct RecordList: View {
//    private let records: [HealthRecord]
//    
//    init(_ records: [HealthRecord]) {
//        self.records = records
//    }
//    
//    var body: some View {
//        List {
//            if records.isEmpty {
//                ContentUnavailableView("No records", systemImage: "hammer", description: Text("There're no records to show"))
//            }
//            
//            ForEach(records) { record in
//                let formatted = String(format: "%.2f", record.value)
//                
//                Text(formatted)
//            }
//        }
//    }
//}
//
//#Preview {
//    RecordList([])
//}
