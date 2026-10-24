import SwiftUI

struct DebugSettings: View {
    @EnvironmentObject private var store: ValueStore
    
    @State private var showIPhones = false

    let versionAndBuild = "v\(Bundle.version ?? "-") (B\(Bundle.build ?? "-"))"
    
    var body: some View {
        List {
            Section {
                LabeledContent(String("Version"), value: versionAndBuild)
            }
            
            Section {
                Toggle(String("Debug mode"), isOn: $store.debugMode)

                Toggle(String("Status bar"), isOn: $store.showStatusBar)
            }

            Section {
                Button(String("iPhones"), systemImage: "iphone") {
                    showIPhones = true
                }
            }
        }
        .navigationTitle(String("Debug settings"))
        .fullScreenCover(isPresented: $showIPhones) {
            IPhoneListView()
        }
    }
}

#Preview {
    NavigationStack {
        DebugSettings()
            .withNavDestinations()
    }
    .environmentObject(ValueStore())
}
