import Device

extension DeviceVM {
    static let waterResistance = Device.current.waterResistance ?? "Unknown"
    static let waterResistanceDescription = Device.current.waterResistanceDescription ?? "Unknown"
}
