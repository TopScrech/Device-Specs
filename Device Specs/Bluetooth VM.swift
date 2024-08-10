import CoreBluetooth

@Observable
final class BluetoothVM: NSObject, CBCentralManagerDelegate {
    var centralManager: CBCentralManager!
    var isBluetoothLeEnabled = ""
    
    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            isBluetoothLeEnabled = "Yes"
        } else {
            isBluetoothLeEnabled = "Unavailable"
        }
    }
}
