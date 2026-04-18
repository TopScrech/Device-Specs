import SwiftUI

@Observable
final class GPUFamiliesVM {
    var supportedFamilies: [GPUFamily] {
        families.filter {
            $0.supported
        }
    }
    
    var unsupportedFamilies: [GPUFamily] {
        families.filter {
            !$0.supported
        }
    }
    
    private var families: [GPUFamily] {
        guard let device = MTLCreateSystemDefaultDevice() else {
            return []
        }
        
        return [
            .init("Apple 1", supported: device.supportsFamily(.apple1)),
            .init("Apple 2", supported: device.supportsFamily(.apple2)),
            .init("Apple 3", supported: device.supportsFamily(.apple3)),
            .init("Apple 4", supported: device.supportsFamily(.apple4)),
            .init("Apple 5", supported: device.supportsFamily(.apple5)),
            .init("Apple 6", supported: device.supportsFamily(.apple6)),
            .init("Apple 7", supported: device.supportsFamily(.apple7)),
            .init("Apple 8", supported: device.supportsFamily(.apple8)),
            .init("Apple 9", supported: device.supportsFamily(.apple9)),
            .init("Common 1", supported: device.supportsFamily(.common1)),
            .init("Common 2", supported: device.supportsFamily(.common2)),
            .init("Common 3", supported: device.supportsFamily(.common3)),
            .init("Mac 2", supported: device.supportsFamily(.mac2)),
            .init("Metal 3", supported: device.supportsFamily(.metal3))
        ]
    }
}
