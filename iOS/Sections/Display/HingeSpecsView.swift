import SwiftUI

#if os(iOS)
@available(iOS 27.1, *)
struct HingeSpecsView: View {
    @State private var hinge: DeviceHinge?
    @State private var hasReceivedContext = false

    var body: some View {
        Section("Hinge") {
            if let hinge {
                LabeledContent("Current angle") {
                    Text("\(hinge.angle.degrees, format: .number.precision(.fractionLength(0...1)))°")
                        .monospacedDigit()
                }

                LabeledContent("Status") {
                    Text(DisplayVM.hingeStatusDescription(hinge.status))
                }
            } else {
                Text(hasReceivedContext ? "Hinge unavailable" : "Waiting for hinge data")
                    .foregroundStyle(.secondary)
            }
        }
        .onHingeChange { _, newContext in
            hinge = newContext.hinge
            hasReceivedContext = true
        }
    }
}
#endif
