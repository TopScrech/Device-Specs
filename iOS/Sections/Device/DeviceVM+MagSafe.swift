import Device

extension DeviceVM {
    static let isMagsafeSupported = Device.current.has(.magSafe)
}
