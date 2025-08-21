import SwiftUI

struct SystemReportView: View {
    @State private var vm = SystemReportVM()
    
    var body: some View {
        VStack {
            Button("Create a full system report") {
                vm.fetchSystemReport()
            }
            .disabled(vm.isFetching)
            
            if vm.isFetching {
                ProgressView(value: vm.progress, total: 1)
                    .padding()
            }
            
            if !vm.isFetching, !vm.output.isEmpty {
                Image(systemName: "text.document")
                    .largeTitle()
                    .padding()
                
                if let url = vm.reportURL {
                    ShareLink(item: url)
                }
                
                Button("Save...") {
                    vm.saveFileToLocation("test.txt")
                }
            }
        }
    }
}

#Preview {
    SystemReportView()
}
