import SwiftUI
import OSLog

@Observable
final class BatteryVM {
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "DeviceSpecs", category: "BatteryVM")
    // Model
    var serialNumber: String?
    var deviceName: String?
    var packLotCode: String?
    var pcbLotCode: String?
    var firmwareVersion: String?
    var hardwareRevision: String?
    var cellRevision: String?
    
    // Charge
    var isBelowWarningLevel: Bool?
    var isFullyCharged: Bool?
    var isCharging: Bool?
    var stateOfCharge: String?
    
    // Health
    var cycleCount: Int?
    var condition: String?
    var maximumCapacityPercent: String?
    
    init() {
        fetchBatteryInfo()
    }
    
    func fetchBatteryInfo() {
        DispatchQueue.global(qos: .background).async {
            // Create a matching dictionary to find the battery service
            guard let matchingDict = IOServiceMatching("AppleSmartBattery") else {
                self.logger.error("Failed to create matching dictionary")
                return
            }
            
            // Get the battery service
            let serviceObject = IOServiceGetMatchingService(kIOMainPortDefault, matchingDict)
            
            if serviceObject == 0 {
                self.logger.error("Battery service not found")
                return
            }
            
            // Retrieve the properties of the battery
            var properties: Unmanaged<CFMutableDictionary>?
            
            let result = IORegistryEntryCreateCFProperties(serviceObject, &properties, kCFAllocatorDefault, 0)
            IOObjectRelease(serviceObject)
            
            if result != KERN_SUCCESS {
                self.logger.error("Failed to retrieve battery properties")
                return
            }
            
            // Extract the properties
            guard let props = properties?.takeRetainedValue() as NSDictionary? else {
                self.logger.error("Battery properties could not be read")
                return
            }
            
            self.logger.info("Battery properties: \(String(describing: props))")
            
            DispatchQueue.main.async {
                // Model Information
                if let serialNumber = props["Serial"] as? String {
                    self.serialNumber = serialNumber
                }
                
                if let deviceName = props["DeviceName"] as? String {
                    self.deviceName = deviceName
                }
                
                // Parse ManufacturerData to get specific properties
                if let manufacturerData = props["ManufacturerData"] as? Data {
                    let dataBytes = [UInt8](manufacturerData)
                    
                    if dataBytes.count >= 10 {
                        // Big-endian format
                        let packLotCode = UInt16(dataBytes[0]) << 8 | UInt16(dataBytes[1])
                        let pcbLotCode = UInt16(dataBytes[2]) << 8 | UInt16(dataBytes[3])
                        let firmwareVersion = UInt16(dataBytes[4]) << 8 | UInt16(dataBytes[5])
                        let hardwareRevision = UInt16(dataBytes[6]) << 8 | UInt16(dataBytes[7])
                        let cellRevision = UInt16(dataBytes[8]) << 8 | UInt16(dataBytes[9])
                        
                        // Convert to strings
                        self.packLotCode = String(packLotCode)
                        self.pcbLotCode = String(pcbLotCode)
                        self.firmwareVersion = String(format: "%04x", firmwareVersion)
                        self.hardwareRevision = String(format: "%04x", hardwareRevision)
                        self.cellRevision = String(format: "%04x", cellRevision)
                    } else {
                        self.logger.warning("ManufacturerData is too short")
                    }
                } else {
                    self.logger.warning("ManufacturerData not found")
                }
                
                // Charge Information
                self.isBelowWarningLevel = (props["AtCriticalLevel"] as? Int) == 1
                
                self.isFullyCharged = (props["FullyCharged"] as? Int) == 1
                
                self.isCharging = (props["IsCharging"] as? Int) == 1
                
                if let currentCapacity = props["CurrentCapacity"] as? Int,
                   let maxCapacity = props["MaxCapacity"] as? Int {
                    let state = Int(Double(currentCapacity) / Double(maxCapacity) * 100)
                    self.stateOfCharge = "\(state)%"
                }
                
                // Health Information
                if let cycleCount = props["CycleCount"] as? Int {
                    self.cycleCount = cycleCount
                }
                
                if let permanentFailureStatus = props["PermanentFailureStatus"] as? Int, permanentFailureStatus == 0 {
                    self.condition = "Normal"
                } else {
                    self.condition = "Service Battery"
                }
                
                if let maxCapacity = props["MaxCapacity"] as? Int {
                    self.maximumCapacityPercent = "\(maxCapacity)%"
                }
            }
        }
    }
}
