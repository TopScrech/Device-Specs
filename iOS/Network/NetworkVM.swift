import ScrechKit
import Network

@Observable
final class NetworkVM {
    private(set) var publicIp = ""
    private(set) var networkInterface = ""
    private(set) var destinationIpAddress = ""
    private(set) var subnetMask = ""
    
    private(set) var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
    
    func getIPAddresses() async {
        let path = "https://bluewindsolution.com/tools/getpublicip.php"
        
        guard let url = URL(string: path) else {
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let ipString = String(data: data, encoding: .utf8) {
                let publicIp = ipString.trimmingCharacters(in: .whitespacesAndNewlines)
                self.publicIp = publicIp
            }
        } catch {
            print("Error:", error)
        }
        
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        
        guard getifaddrs(&ifaddr) == 0 else {
            return
        }
        
        var ptr = ifaddr
        
        while ptr != nil {
            let interface = ptr!.pointee
            
            guard
                interface.ifa_addr.pointee.sa_family == UInt8(AF_INET)
            else {
                ptr = interface.ifa_next
                continue
            }
            
            let ifaName = String.decodeCString(interface.ifa_name)
            
            guard ifaName == "en0" else {
                ptr = interface.ifa_next
                continue
            }
            
            // Network interface
            var addr = interface.ifa_addr.pointee
            var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
            
            getnameinfo(
                &addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                &hostname, socklen_t(hostname.count),
                nil, socklen_t(0), NI_NUMERICHOST
            )
            
            networkInterface = String.decodeCString(hostname)
            
            // Subnet mask
            if let netmask = interface.ifa_netmask {
                var netmaskAddr = netmask.pointee
                var netmaskHost = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                
                getnameinfo(
                    &netmaskAddr, socklen_t(netmaskAddr.sa_len),
                    &netmaskHost, socklen_t(netmaskHost.count),
                    nil, socklen_t(0), NI_NUMERICHOST
                )
                
                subnetMask = String.decodeCString(netmaskHost)
            }
            
            // Router IP (gateway)
            if let dstAddr = interface.ifa_dstaddr {
                var dstAddr = dstAddr.pointee
                var dstHostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                
                getnameinfo(
                    &dstAddr, socklen_t(dstAddr.sa_len),
                    &dstHostname, socklen_t(dstHostname.count),
                    nil, socklen_t(0), NI_NUMERICHOST
                )
                
                destinationIpAddress = String.decodeCString(dstHostname)
            }
            
            ptr = interface.ifa_next
        }
        
        freeifaddrs(ifaddr)
    }
}
