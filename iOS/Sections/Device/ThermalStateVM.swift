import SwiftUI

@Observable
final class ThermalStateVM {
    private(set) var state = ProcessInfo.processInfo.thermalState

    var title: LocalizedStringKey {
        switch state {
        case .nominal: "Nominal"
        case .fair: "Fair"
        case .serious: "Serious"
        case .critical: "Critical"
        @unknown default: "Unknown"
        }
    }

    var warningColor: Color? {
        switch state {
        case .serious: .yellow
        case .critical: .red
        default: nil
        }
    }

    var warningTitle: LocalizedStringKey {
        state == .critical ? "Critical thermal state" : "Serious thermal state"
    }

    func monitor() async {
        let notifications = NotificationCenter.default.notifications(
            named: ProcessInfo.thermalStateDidChangeNotification
        ).map { _ in () }

        refresh()

        for await _ in notifications {
            guard !Task.isCancelled else { return }
            refresh()
        }
    }

    func refresh() {
        state = ProcessInfo.processInfo.thermalState
    }
}
