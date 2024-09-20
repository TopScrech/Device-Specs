import ScrechKit

struct MagneticFieldData: View {
    @State private var vm = MagneticVM()
    
    var body: some View {
        if let raw = vm.rawMagneticField {
            let x = String(format: "%.2f µT", raw.x)
            let y = String(format: "%.2f µT", raw.y)
            let z = String(format: "%.2f µT", raw.z)
            
            ListParameter("Raw X", parameter: x)
            ListParameter("Raw Y", parameter: y)
            ListParameter("Raw Z", parameter: z)
        }        
    }
}

#Preview {
    List {
        MagneticFieldData()
    }
}
