import SwiftUI

extension Bool? {
    func yesOrNo() -> String {
        guard let self else { return "-" }
        return self ? String(localized: "Yes") : String(localized: "No")
    }
}

extension Bool {
    func yesOrNo() -> String {
        return self ? String(localized: "Yes") : String(localized: "No")
    }
}
