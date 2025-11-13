extension String {
    /// Decodes a null-terminated C char array or pointer using Swift's UTF-8 initializer
    static func decodeCString(_ characters: [CChar]) -> String {
        let length = characters.firstIndex(of: 0) ?? characters.count
        
        return characters.withUnsafeBufferPointer { buffer in
            let truncated = UnsafeBufferPointer(start: buffer.baseAddress, count: length)
            
            return truncated.withMemoryRebound(to: UInt8.self) {
                String(decoding: $0, as: UTF8.self)
            }
        }
    }
    
    static func decodeCString(_ pointer: UnsafePointer<CChar>) -> String {
        var length = 0
        
        while pointer[length] != 0 {
            length += 1
        }
        
        return UnsafeBufferPointer(start: pointer, count: length).withMemoryRebound(to: UInt8.self) {
            String(decoding: $0, as: UTF8.self)
        }
    }
}
