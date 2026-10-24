import Device

#if os(iOS)
extension DeviceVM {
    static var dockConnector: String {
        switch Device.current.dockConnector {
        case .usbC: "USB-C"
        case .lightning: "Lightning"
        case .thirtyPin: "30-pin"
        case .none: "None"
        case .unknown: "Unknown"
        }
    }
}
#endif
