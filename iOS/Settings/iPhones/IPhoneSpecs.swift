import Foundation
import Device

enum IPhoneSpecs {
    static func rows(for phone: DeviceDefinition) -> [(title: String, value: String)] {
        categorizedRows(for: phone).map { (title: $0.title, value: $0.value) }
    }

    static func sections(for phone: DeviceDefinition) -> [(section: IPhoneSpecSection, rows: [(title: String, value: String)])] {
        let rows = categorizedRows(for: phone)
        return IPhoneSpecSection.allCases.compactMap { section in
            let matches = rows.filter { $0.section == section }.map { (title: $0.title, value: $0.value) }
            return matches.isEmpty ? nil : (section: section, rows: matches)
        }
    }

    private static func categorizedRows(for phone: DeviceDefinition) -> [(title: String, value: String, section: IPhoneSpecSection)] {
        var rows: [(title: String, value: String, section: IPhoneSpecSection)] = []
        var section = IPhoneSpecSection.device

        func add(_ title: String, _ value: String?) {
            rows.append((title, value.flatMap { $0.isEmpty ? nil : $0 } ?? "-", section))
        }

        add("Name", phone.name)
        add("Identifiers", phone.identifiers.joined(separator: ", "))
        add("Model numbers", phone.modelNumbers.joined(separator: ", "))
        add("Announcement date", date(phone.announcementDate))
        add("Release date", date(phone.releaseDate))
        section = .processor
        add("CPU", phone.cpu?.description)
        add("Technology node", phone.cpu?.techNode)
        add("Maximum clock speed", phone.cpu?.maxClockSpeed)
        add("Instruction set", phone.cpu?.instructionSet)
        add("L1 instruction cache", phone.cpu?.l1InstructionCache)
        add("L1 data cache", phone.cpu?.l1DataCache)
        add("L2 cache", phone.cpu?.l2Cache)
        add("L3 cache", phone.cpu?.l3Cache)
        add("Neural Engine cores", phone.neuralEngineCores())
        add("Neural Engine TOPS", phone.cpu?.neuralEngineTOPS)
        section = .ram
        add("Memory type", phone.cpu?.memoryType)

        section = .device
        add("Bluetooth", phone.bluetoothVersion)
        add("Dock connector", connector(phone.dockConnector))
        add("Water resistance", phone.waterResistance)
        add("Water resistance description", phone.waterResistanceDescription)
        section = .network
        add("eSIM-only models", phone.eSIMOnlyModelNumbers.map {
            $0.isEmpty ? "None" : $0.sorted().joined(separator: ", ")
        })

        func addBattery(_ title: String, _ capacity: BatteryCapacity?) {
            add("\(title) capacity", number(capacity?.milliampHours, unit: "mAh"))
            add("\(title) energy", number(capacity?.wattHours, unit: "Wh"))
            add("\(title) count", capacity.map { String($0.batteryCount) })
            add("\(title) individual capacities", capacity.map {
                $0.batteryMilliampHours.map { number($0, unit: "mAh") ?? "-" }.joined(separator: ", ")
            })
            add("\(title) individual energies", capacity.map {
                $0.batteryWattHours.map { number($0, unit: "Wh") ?? "-" }.joined(separator: ", ")
            })
        }

        section = .battery
        add("Voltage", phone.voltage)
        addBattery("Battery", phone.batteryCapacity)
        addBattery("eSIM-only battery", phone.eSIMOnlyBatteryCapacity)

        if phone.batteryCapacityOverrides.isEmpty {
            add("Battery overrides", nil)
        } else {
            for model in phone.batteryCapacityOverrides.keys.sorted() {
                addBattery("Battery (\(model))", phone.batteryCapacityOverrides[model])
            }
        }

        section = .display
        if let displays = phone.displays, !displays.isEmpty {
            for (index, display) in displays.enumerated() {
                let title = "Display \(index + 1)"
                add("\(title) role", String(describing: display.role).capitalized)
                add("\(title) diagonal", number(display.diagonal, unit: "in"))
                add("\(title) resolution", "\(display.resolution.width) × \(display.resolution.height)")
                add("\(title) aspect ratio", display.resolution.formattedAspectRatio)
                add("\(title) pixel density", "\(display.ppi) PPI")
                add("\(title) estimated diagonal", number(display.estimatedDiagonal, unit: "in"))
            }
        } else {
            add("Display role", nil)
            add("Display diagonal", nil)
            add("Display resolution", nil)
            add("Display aspect ratio", nil)
            add("Display pixel density", nil)
            add("Display estimated diagonal", nil)
        }

        section = .device
        add("Capabilities", capabilities(phone.capabilities))

        if phone.capabilityOverrides.isEmpty {
            add("Capability overrides", nil)
        } else {
            for model in phone.capabilityOverrides.keys.sorted() {
                add("Capabilities (\(model))", phone.capabilityOverrides[model].map(capabilities))
            }
        }

        return rows
    }

    private static func number(_ value: Double?, unit: String) -> String? {
        value.map { "\($0.formatted(.number.precision(.fractionLength(0...3)))) \(unit)" }
    }

    private static func date(_ value: DeviceDate?) -> String? {
        value.map {
            let month = $0.month.formatted(.number.grouping(.never).precision(.integerLength(2)))
            let day = $0.day.formatted(.number.grouping(.never).precision(.integerLength(2)))
            return "\($0.year)-\(month)-\(day)"
        }
    }

    private static func connector(_ value: DockConnector) -> String? {
        switch value {
        case .usbC: "USB-C"
        case .lightning: "Lightning"
        case .thirtyPin: "30-pin"
        case .none: "None"
        case .unknown: nil
        }
    }

    private static func capabilities(_ values: Set<Capability>) -> String {
        values.map {
            switch $0 {
            case .lidar: "LiDAR"
            case .roundedDisplayCorners: "Rounded display corners"
            case .magSafe: "MagSafe"
            case .wirelessCharging: "Wireless charging"
            case .fiveG: "5G"
            case .dynamicIsland: "Dynamic Island"
            }
        }.sorted().joined(separator: ", ")
    }
}
