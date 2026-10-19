import Device

extension DeviceVM {
    static let bluetoothVersion = Device.current.bluetoothVersion ?? "Unknown"
}
