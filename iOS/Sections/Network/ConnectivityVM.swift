import Foundation
import Network
import NetworkExtension

@Observable
final class ConnectivityVM {
    @ObservationIgnored private var networkMonitorTask: Task<Void, Never>?
    
    private(set) var type = ""
    private(set) var ssid: String? = nil
    private(set) var bssid: String? = nil
    private(set) var signalStrength: Double? // for Wi-Fi
    private(set) var isSecure: Bool?
    private(set) var didAutoJoin: Bool?
    private(set) var didJustJoin: Bool?
    private(set) var isChosenHelper: Bool? // Indicates whether the calling Hotspot Helper is the chosen helper for this network
    private(set) var securityType: String? // for Wi-Fi
    private(set) var pathStatus: String?
    private(set) var pathUnsatisfiedReason: String?
    private(set) var supportsIPv4 = false
    private(set) var supportsIPv6 = false
    private(set) var supportsDNS = false
    private(set) var lowDataMode = false
    private(set) var linkQuality: String?
    
    init() {
        monitorNetworkStatus()
    }
    
    private func monitorNetworkStatus() {
        networkMonitorTask = Task { @MainActor [weak self] in
            for await path in NWPathMonitor() {
                await self?.updateNetworkStatus(path)
            }
        }
    }
    
    private func updateNetworkStatus(_ path: NWPath) async {
        await getWiFiInfo()
        
        type = networkActiveInterfacesText(path)
        pathStatus = networkStatusText(path.status)
        pathUnsatisfiedReason = path.status == .unsatisfied ? networkUnsatisfiedReasonText(path.unsatisfiedReason) : nil
        supportsIPv4 = path.supportsIPv4
        supportsIPv6 = path.supportsIPv6
        supportsDNS = path.supportsDNS
        lowDataMode = path.isConstrained
        
        if #available(anyAppleOS 26, *) {
            linkQuality = networkLinkQualityText(path.linkQuality)
        } else {
            linkQuality = nil
        }
    }
    
    func getWiFiInfo() async {
        let network = await withCheckedContinuation { continuation in
            NEHotspotNetwork.fetchCurrent {
                continuation.resume(returning: $0)
            }
        }
        
        self.ssid = network?.ssid
        self.bssid = network?.bssid
        self.signalStrength = network?.signalStrength
        self.isSecure = network?.isSecure
        self.didAutoJoin = network?.didAutoJoin
        self.didJustJoin = network?.didJustJoin
        self.isChosenHelper = network?.isChosenHelper
        self.securityType = self.securityTypeString(network?.securityType)
    }
    
    private func securityTypeString(_ type: NEHotspotNetworkSecurityType?) -> String? {
        switch type {
        case .WEP: "WEP"
        case .enterprise: "Enterprise"
        case .open: "Open"
        case .personal: "Personal"
        case .unknown: "Unknown"
        case .none: "None"
        @unknown default: nil
        }
    }
    
    private func networkActiveInterfacesText(_ path: NWPath) -> String {
        let interfaces = [
            NWInterface.InterfaceType.wifi,
            .cellular,
            .wiredEthernet,
            .loopback,
            .other
        ]
        .filter { path.usesInterfaceType($0) }
        .map(networkInterfaceTypeText)
        
        if interfaces.isEmpty {
            return "-"
        } else {
            return interfaces.joined(separator: "\n")
        }
    }
    
    private func networkInterfaceTypeText(_ type: NWInterface.InterfaceType) -> String {
        switch type {
        case .other: "Other"
        case .wifi: "Wi-Fi"
        case .cellular: "Cellular"
        case .wiredEthernet: "Wired Ethernet"
        case .loopback: "Loopback"
        @unknown default: "Unknown"
        }
    }
    
    private func networkStatusText(_ status: NWPath.Status) -> String {
        switch status {
        case .satisfied: "Available"
        case .unsatisfied: "Unavailable"
        case .requiresConnection: "Requires connection"
        @unknown default: "Unknown"
        }
    }
    
    private func networkUnsatisfiedReasonText(_ reason: NWPath.UnsatisfiedReason) -> String {
        switch reason {
        case .notAvailable: "Not available"
        case .cellularDenied: "Cellular denied"
        case .wifiDenied: "Wi-Fi denied"
        case .localNetworkDenied: "Local network denied"
        case .vpnInactive: "VPN inactive"
        @unknown default: "Unknown"
        }
    }
    
    @available(anyAppleOS 26, *)
    private func networkLinkQualityText(_ linkQuality: NWPath.LinkQuality) -> String {
        switch linkQuality {
        case .unknown: "Unknown"
        case .minimal: "Minimal"
        case .moderate: "Moderate"
        case .good: "Good"
        @unknown default: "Unknown"
        }
    }
    
    deinit {
        networkMonitorTask?.cancel()
    }
}

extension NEHotspotNetwork: @unchecked @retroactive Sendable {}
