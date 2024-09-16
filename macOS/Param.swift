import SwiftUI

struct Param: View {
    private let name: LocalizedStringResource
    private let value: String
    
    init(_ name: LocalizedStringResource, param: Bool?) {
        self.name = name
        
        if let param {
            self.value = param ? "Yes" : "No"
        } else {
            self.value = "Unknown"
        }
    }
    
    init(_ name: LocalizedStringResource, param: String?) {
        self.name = name
        
        if let param {
            self.value = param
        } else {
            self.value = "Unknown"
        }
    }
    
    init(_ name: LocalizedStringResource, param: Int?) {
        self.name = name
        
        if let param {
            self.value = param.description
        } else {
            self.value = "Unknown"
        }
    }
    
    var body: some View {
        HStack {
            Text(name)
            
            Spacer()
            
            Text(value)
        }
    }
}
