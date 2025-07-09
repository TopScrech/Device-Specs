import SwiftUI

struct HapticTests: View {
    private let feedbacks: [String: SensoryFeedback] = [
        "Alignment": .alignment,
        "Increase": .increase,
        "Decrease": .decrease,
        "Success": .success,
        "Warning": .warning,
        "Error": .error,
        "Start": .start,
        "Stop": .stop,
        "Level change": .levelChange,
        "Selection": .selection,
        "Impact": .impact,
        "Impacrt (rigid)": .impact(flexibility: .rigid),
        "Impacrt (soft)": .impact(flexibility: .soft),
        "Impacrt (solid)": .impact(flexibility: .solid)
    ]
    
    var body: some View {
        List {
            Section {
                ForEach(feedbacks.sorted(by: { $0.key < $1.key }), id: \.key) { key, feedback in
                    HapticButton(key, feedback: feedback)
                }
                
                HapticButton("Path complete", feedback: .pathComplete)
            } footer: {
                Text("Not all platforms will play feedback in response to certain types")
            }
        }
        .navigationTitle("Haptic Feedback")
        .scrollIndicators(.never)
    }
}

#Preview {
    HapticTests()
}
