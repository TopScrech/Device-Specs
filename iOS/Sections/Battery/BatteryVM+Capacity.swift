import Foundation
import Device

extension BatteryVM {
    var capacity: String {
        Self.capacityDescription(for: Device.current)
    }

    var energyCapacity: String {
        Self.capacityDescription(for: Device.current, format: Self.energyCapacityDescription)
    }

    static func capacityDescription(for device: Device) -> String {
        capacityDescription(for: device, format: Self.capacityDescription)
    }

    private static func capacityDescription(for device: Device, format: (BatteryCapacity) -> String) -> String {
        if let capacity = device.batteryCapacity {
            return format(capacity)
        }

        if let definition = device.definition,
           let standard = definition.batteryCapacity,
           let eSIMOnly = definition.eSIMOnlyBatteryCapacity {
            let standardDescription = format(standard)
            let eSIMDescription = format(eSIMOnly)
            return "\(standardDescription) (SIM tray)\n\(eSIMDescription) (eSIM-only)"
        }

        return "Unknown"
    }

    static func capacityDescription(for capacity: BatteryCapacity?) -> String {
        guard let capacity else { return "Unknown" }

        let format = FloatingPointFormatStyle<Double>.number.precision(.fractionLength(0...3))

        if let milliampHours = capacity.milliampHours {
            let total = "\(milliampHours.formatted(format)) mAh"

            if capacity.batteryMilliampHours.count > 1 {
                let components = capacity.batteryMilliampHours
                    .map { $0.formatted(format) }
                    .joined(separator: " + ")
                return "\(total) (\(components))"
            }

            return total
        }

        return "Unknown"
    }

    private static func energyCapacityDescription(for capacity: BatteryCapacity) -> String {
        guard let wattHours = capacity.wattHours else { return "Unknown" }

        return "\(wattHours.formatted(.number.precision(.fractionLength(0...3)))) Wh"
    }
}
