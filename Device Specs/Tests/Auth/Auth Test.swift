import SwiftUI

struct AuthTest: View {
    @State private var vm = AuthVM()
    
    var body: some View {
        Button {
            vm.checkAvailability()
        } label: {
            HStack {
                Text("Biometric authentication")
                
                Spacer()
                
                Image(systemName: vm.isAuthenticated ? "checkmark" : vm.icon)
                    .title3()
                    .foregroundStyle(vm.isAuthenticated ? .green : .secondary)
                
                Text(vm.type)
                    .secondary()
            }
        }
        .disabled(vm.type == "None")
        .foregroundStyle(.foreground)
        .alert("Error", isPresented: $vm.alertError) {
            
        } message: {
            Text(vm.errorMessage)
        }
    }
}

#Preview {
    List {
        AuthTest()
    }
}
