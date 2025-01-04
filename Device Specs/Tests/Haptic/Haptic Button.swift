import SwiftUI

struct HapticButton: View {
    private let name: String
    private let feedback: SensoryFeedback
    
    init(_ name: String, feedback: SensoryFeedback) {
        self.name = name
        self.feedback = feedback
    }
    
    @State private var trigger = false
    
    var body: some View {
        Button(name) {
            trigger.toggle()
        }
        .sensoryFeedback(feedback, trigger: trigger)
        .foregroundStyle(.foreground)
    }
}
