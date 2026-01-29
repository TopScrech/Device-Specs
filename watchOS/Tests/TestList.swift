import ScrechKit

struct TestList: View {
    var body: some View {
        List {
            ColorTestList()
#if !os(tvOS)
            ListLink("Haptic feedback", icon: "hand.tap") {
                HapticTests()
            }
#endif
        }
    }
}

#Preview {
    TestList()
        .darkSchemePreferred()
}
