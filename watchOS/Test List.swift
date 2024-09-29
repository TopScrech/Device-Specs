import ScrechKit

struct TestList: View {
    var body: some View {
        List {
            ColorTestList()
            
            ListLink("Haptic feedback", icon: "hand.tap") {
                HapticTests()
            }
        }
    }
}

#Preview {
    TestList()
}
