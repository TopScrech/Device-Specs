import ScrechKit

struct GPUFamilies: View {
    private let device: MTLDevice
    
    init(_ device: MTLDevice) {
        self.device = device
    }
    
    var body: some View {
        ListParameter("Apple 1", parameter: device.supportsFamily(.apple1) ? "Yes" : "No")
        ListParameter("Apple 2", parameter: device.supportsFamily(.apple2) ? "Yes" : "No")
        ListParameter("Apple 3", parameter: device.supportsFamily(.apple3) ? "Yes" : "No")
        ListParameter("Apple 4", parameter: device.supportsFamily(.apple4) ? "Yes" : "No")
        ListParameter("Apple 5", parameter: device.supportsFamily(.apple5) ? "Yes" : "No")
        ListParameter("Apple 6", parameter: device.supportsFamily(.apple6) ? "Yes" : "No")
        ListParameter("Apple 7", parameter: device.supportsFamily(.apple7) ? "Yes" : "No")
        ListParameter("Apple 8", parameter: device.supportsFamily(.apple8) ? "Yes" : "No")
        ListParameter("Apple 9", parameter: device.supportsFamily(.apple9) ? "Yes" : "No")
        ListParameter("Common 1", parameter: device.supportsFamily(.common1) ? "Yes" : "No")
        ListParameter("Common 2", parameter: device.supportsFamily(.common2) ? "Yes" : "No")
        ListParameter("Common 3", parameter: device.supportsFamily(.common3) ? "Yes" : "No")
        ListParameter("Mac 2", parameter: device.supportsFamily(.mac2) ? "Yes" : "No")
        ListParameter("Metal 3", parameter: device.supportsFamily(.metal3) ? "Yes" : "No")
    }
}

#Preview {
    if let device = MTLCreateSystemDefaultDevice() {
        GPUFamilies(device)
    }
}
