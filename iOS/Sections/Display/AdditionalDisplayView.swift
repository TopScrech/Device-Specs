import SwiftUI
import Device

#if os(iOS) || os(watchOS)
struct AdditionalDisplayView: View {
    let display: DeviceDisplay

    var body: some View {
        Section("Outer display") {
            LabeledContent("Screen resolution", value: "\(display.resolution.width) x \(display.resolution.height)")
            LabeledContent("Screen size", value: DisplayVM.diagonalDescription(display))
            LabeledContent("Aspect ratio", value: DisplayAspectRatioFormatter.format(
                width: display.resolution.aspectRatio.width,
                height: display.resolution.aspectRatio.height
            ))
            LabeledContent("Pixel density", value: "\(display.ppi) PPI")
        }
    }
}
#endif
