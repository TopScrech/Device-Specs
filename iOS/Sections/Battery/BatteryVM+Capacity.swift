import Foundation
import Device

extension BatteryVM {
    var capacity: String {
        Self.capacityDescription(for: Device.current.batteryCapacity)
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

        if let wattHours = capacity.wattHours {
            return "\(wattHours.formatted(format)) Wh"
        }

        return "Unknown"
    }
}
