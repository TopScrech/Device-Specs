import SwiftUI

struct SpecItem: View {
    private let name: String
    private let param: String
    
    init(_ name: String, param: String) {
        self.name = name
        self.param = param
    }
    
    var body: some View {
        HStack {
            Text(name)
            
            Spacer()
            
            Text(param)
        }
    }
}
