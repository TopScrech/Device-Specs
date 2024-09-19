import SwiftUI

struct SpecCard: View {
    private let name: LocalizedStringKey
    private let spec: String
    
    init(_ name: LocalizedStringKey, spec: String) {
        self.name = name
        self.spec = spec
    }
    
    var body: some View {
        HStack {
            Text(name)
            
            Spacer()
            
            Text(spec)
                .foregroundStyle(.secondary)
        }
    }
}

#Preview {
    SpecCard("Preview", spec: "12345678")
}
