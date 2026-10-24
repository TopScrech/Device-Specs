import SwiftUI
import Device

@Observable
final class IPhoneListVM {
    private static let selectedPhoneKey = "debugSelectedIPhoneIdentifier"

    var selectedPhone: DeviceDefinition? {
        didSet {
            guard let identifier = selectedPhone?.identifiers.first else { return }
            UserDefaults.standard.set(identifier, forKey: Self.selectedPhoneKey)
        }
    }

    init() {
        let identifier = UserDefaults.standard.string(forKey: Self.selectedPhoneKey)
        selectedPhone = Device.iPhones.first { phone in
            phone.identifiers.contains { $0 == identifier }
        }
    }

    static let families: [[DeviceDefinition]] = {
        var groups: [[DeviceDefinition]] = []
        var dateIndices: [DeviceDate: Int] = [:]

        for phone in Device.iPhones {
            if let date = phone.announcementDate {
                if let index = dateIndices[date] {
                    groups[index].append(phone)
                } else {
                    dateIndices[date] = groups.count
                    groups.append([phone])
                }
            } else {
                groups.append([phone])
            }
        }

        return groups.reversed().map { $0.reversed() }
    }()

    var selectedSpecs: Set<String> = []

    static let availableSpecs: [String] = {
        var seen: Set<String> = ["Name"]
        return Device.iPhones.flatMap { IPhoneSpecs.rows(for: $0) }.compactMap {
            let key = selectionKey(for: $0.title)
            return seen.insert(key).inserted ? key : nil
        }
    }()

    func toggle(_ spec: String) {
        if !selectedSpecs.insert(spec).inserted {
            selectedSpecs.remove(spec)
        }
    }

    func visibleRows(for phone: DeviceDefinition) -> [(title: String, value: String)] {
        let rows = IPhoneSpecs.rows(for: phone)
        return Self.availableSpecs.filter { selectedSpecs.contains($0) }.flatMap { spec in
            let matches = rows.filter { Self.selectionKey(for: $0.title) == spec }
            return matches.isEmpty ? [(title: spec, value: "-")] : matches
        }
    }

    private static func selectionKey(for title: String) -> String {
        if title.hasPrefix("Battery (") {
            return "Battery overrides"
        }

        if title.hasPrefix("Capabilities (") {
            return "Capability overrides"
        }

        let words = title.split(separator: " ")
        if words.first == "Display", words.count > 2, Int(words[1]) != nil {
            return (["Display"] + words.dropFirst(2).map(String.init)).joined(separator: " ")
        }

        return title
    }
}
