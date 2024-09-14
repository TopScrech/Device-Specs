import SwiftUI

@Observable
final class BatteryVM {
    // Model
    var serialNumber = "Unknown"
    var deviceName = "Unknown"
    var packLotCode = "Unknown"
    var pcbLotCode = "Unknown"
    var firmwareVersion = "Unknown"
    var hardwareRevision = "Unknown"
    var cellRevision = "Unknown"
    
    // Charge
    var isBelowWarningLevel: Bool?
    var isFullyCharged: Bool?
    var isCharging: Bool?
    var stateOfCharge: Int?
    
    // Health
    var cycleCount: Int?
    var condition = "Unknown"
    var maximumCapacityPercent: Int?
    
    init() {
        fetchBatteryInfo()
    }
    
    func fetchBatteryInfo() {
        DispatchQueue.global(qos: .background).async {
            // Create a matching dictionary to find the battery service
            guard let matchingDict = IOServiceMatching("AppleSmartBattery") else {
                print("Failed to create matching dictionary")
                return
            }
            
            // Get the battery service
            let serviceObject = IOServiceGetMatchingService(kIOMainPortDefault, matchingDict)
            
            if serviceObject == 0 {
                print("Battery service not found")
                return
            }
            
            // Retrieve the properties of the battery
            var properties: Unmanaged<CFMutableDictionary>?
            
            let result = IORegistryEntryCreateCFProperties(serviceObject, &properties, kCFAllocatorDefault, 0)
            IOObjectRelease(serviceObject)
            
            if result != KERN_SUCCESS {
                print("Failed to retrieve battery properties")
                return
            }
            
            // Extract the properties
            if let props = properties?.takeRetainedValue() as NSDictionary? {
                print(props)
                
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
                            print("ManufacturerData is too short")
                        }
                    } else {
                        print("ManufacturerData not found")
                    }
                    
                    // Charge Information
                    self.isBelowWarningLevel = (props["AtCriticalLevel"] as? Int) == 1
                    self.isFullyCharged = (props["FullyCharged"] as? Int) == 1
                    self.isCharging = (props["IsCharging"] as? Int) == 1
                    
                    if let currentCapacity = props["CurrentCapacity"] as? Int,
                       let maxCapacity = props["MaxCapacity"] as? Int {
                        self.stateOfCharge = Int(Double(currentCapacity) / Double(maxCapacity) * 100)
                    }
                    
                    // Health Information
                    self.cycleCount = props["CycleCount"] as? Int
                    
                    if let permanentFailureStatus = props["PermanentFailureStatus"] as? Int, permanentFailureStatus == 0 {
                        self.condition = "Normal"
                    } else {
                        self.condition = "Service Battery"
                    }
                    
                    if let maxCapacity = props["MaxCapacity"] as? Int,
                       let designCapacity = props["DesignCapacity"] as? Int {
                        self.maximumCapacityPercent = Int(Double(maxCapacity) / Double(designCapacity) * 100)
                    }
                }
            } else {
                print("Battery properties could not be read")
            }
        }
    }
}
