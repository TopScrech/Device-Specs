import Foundation

struct GPUFamily: Identifiable {
    let id = UUID()
    
    let name: String
    let supported: Bool
    
    init(_ name: String, supported: Bool) {
        self.name = name
        self.supported = supported
    }
}
