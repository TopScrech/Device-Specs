import ScrechKit

struct MagneticFieldData: View {
    @State private var vm = MagneticVM()
    
    var body: some View {
        if let raw = vm.rawMagneticField {
            let x = String(format: "%.2f µT", raw.x)
            let y = String(format: "%.2f µT", raw.y)
            let z = String(format: "%.2f µT", raw.z)
            
            Section("Magnetic field") {
                ListParam("Raw X", param: x)
                ListParam("Raw Y", param: y)
                ListParam("Raw Z", param: z)
            }
        }
    }
}

#Preview {
    List {
        MagneticFieldData()
    }
}
