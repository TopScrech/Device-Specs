import SwiftUI

struct SystemReportView: View {
    @State private var vm = SystemReportVM()
    
    var body: some View {
        VStack {
            Button("Create a complete system report") {
                vm.fetchSystemReport()
            }
            .disabled(vm.isFetching)
            
            if vm.isFetching {
                ProgressView(value: vm.progress, total: 1.0)
                    .padding()
            }
        }
    }
}

#Preview {
    SystemReportView()
}
