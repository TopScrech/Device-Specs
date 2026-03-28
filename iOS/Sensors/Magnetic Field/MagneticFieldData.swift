import SwiftUI

struct MagneticFieldData: View {
    @State private var vm = MagneticVM()
    
    var body: some View {
        Group {
            if let raw = vm.rawMagneticField {
                let x = String(format: "%.2f µT", raw.x)
                let y = String(format: "%.2f µT", raw.y)
                let z = String(format: "%.2f µT", raw.z)
                
                Section("Magnetic field") {
                    LabeledContent("Raw X", value: x)
                    LabeledContent("Raw Y", value: y)
                    LabeledContent("Raw Z", value: z)
                }
            }
        }
        .onAppear {
            vm.onAppear()
        }
    }
}

#Preview {
    List {
        MagneticFieldData()
    }
    .darkSchemePreferred()
}
