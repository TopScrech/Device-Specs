import SwiftUI

struct ClockView: View {
    var body: some View {
        Section {
            TimelineView(.periodic(from: Date(), by: 1)) { context in
                VStack(alignment: .leading) {
                    Text(context.date, style: .date)
                        .headline()
                    
                    Text(context.date, format: .dateTime.hour().minute().second())
                        .title3()
                }
            }
        }
    }
}

#Preview {
    ClockView()
}
