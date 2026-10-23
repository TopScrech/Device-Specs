import SwiftUI

struct DisplaySpecs: View {
#if os(iOS)
    @ObservedObject private var store = ValueStore.shared
#endif

    @State private var brightness = 0.0
    
    init() {
        _brightness = State(initialValue: DisplayVM.brightness ?? 0)
    }
    
    var body: some View {
        List {
            Section {
                LabeledContent("Screen resolution", value: DisplayVM.resolution)
                LabeledContent("Screen size", value: DisplayVM.diagonalSize)
                LabeledContent("Aspect ratio", value: DisplayVM.aspectRatio)
                LabeledContent("Pixel density", value: DisplayVM.pixelDencity ?? "-")
            } header: {
                if DisplayVM.displays.count > 1 {
                    Text("Inner display")
                }
            }

            ForEach(DisplayVM.displays.dropFirst(), id: \.role) {
                AdditionalDisplayView(display: $0)
            }
#if !os(watchOS)
            LabeledContent("Refresh rate", value: DisplayVM.refreshRate)
#endif
            
            LabeledContent("Rounded corners", value: DisplayVM.roundedCorners.yesOrNo())

            if DisplayVM.brightness != nil {
                Section {
                    LabeledContent("Brightness", value: "\(Int(brightness))%")

#if !os(watchOS) && !EXTENSION
                    Slider(value: $brightness, in: 0...100, step: 5) {
                        Text("Brightness")
                    }
#endif
                }
            }
        }
        .navigationTitle("Display")
        .onChange(of: brightness) { _, newValue in
            DisplayVM.setBrightness(newValue)
        }
#if !os(watchOS)
        .task {
            for await _ in NotificationCenter.default.notifications(named: UIApplication.didBecomeActiveNotification) {
                withAnimation {
                    brightness = DisplayVM.brightness ?? 0
                }
            }
        }
#endif
    }
}

#Preview {
    NavigationStack {
        DisplaySpecs()
    }
    .environment(DisplayVM())
    .darkSchemePreferred()
}
