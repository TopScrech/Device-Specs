import SwiftUI

extension LabeledContent where Label == SwiftUI.Label<Text, Image>, Content == Text {
    init(_ title: String, icon: String, value: String) {
        self.init {
            Text(value)
        } label: {
            Label(title, systemImage: icon)
        }
    }
}
