import ScrechKit

struct GPUFamilies: View {
    private let device: MTLDevice
    
    init(_ device: MTLDevice) {
        self.device = device
    }
    
    var body: some View {
        List {
            ListParam("Apple 1", param: device.supportsFamily(.apple1) ? "Yes" : "No")
            ListParam("Apple 2", param: device.supportsFamily(.apple2) ? "Yes" : "No")
            ListParam("Apple 3", param: device.supportsFamily(.apple3) ? "Yes" : "No")
            ListParam("Apple 4", param: device.supportsFamily(.apple4) ? "Yes" : "No")
            ListParam("Apple 5", param: device.supportsFamily(.apple5) ? "Yes" : "No")
            ListParam("Apple 6", param: device.supportsFamily(.apple6) ? "Yes" : "No")
            ListParam("Apple 7", param: device.supportsFamily(.apple7) ? "Yes" : "No")
            ListParam("Apple 8", param: device.supportsFamily(.apple8) ? "Yes" : "No")
            ListParam("Apple 9", param: device.supportsFamily(.apple9) ? "Yes" : "No")
            ListParam("Common 1", param: device.supportsFamily(.common1) ? "Yes" : "No")
            ListParam("Common 2", param: device.supportsFamily(.common2) ? "Yes" : "No")
            ListParam("Common 3", param: device.supportsFamily(.common3) ? "Yes" : "No")
            ListParam("Mac 2", param: device.supportsFamily(.mac2) ? "Yes" : "No")
            ListParam("Metal 3", param: device.supportsFamily(.metal3) ? "Yes" : "No")
        }
        .navigationTitle("Supported GPU families")
        .scrollIndicators(.never)
    }
}

#Preview {
    if let device = MTLCreateSystemDefaultDevice() {
        GPUFamilies(device)
    }
}
