import Foundation
import SystemConfiguration.CaptiveNetwork
import Network

@Observable
final class NetworkVM {
    var networkinterface = ""
    var router = ""
    var subnetMask = ""
    var publicIp = ""
    
    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
    
    func getIPAddresses() {
        do {
            let ip = try String(contentsOf: URL(string: "https://www.bluewindsolution.com/tools/getpublicip.php")!, encoding: .utf8)
            publicIp = ip.trimmingCharacters(in: .whitespaces)
        } catch {
            print("Error: \(error)")
        }
        
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        
        guard getifaddrs(&ifaddr) == 0 else {
            return
        }
        
        var ptr = ifaddr
        
        while ptr != nil {
            let interface = ptr!.pointee
            
            guard interface.ifa_addr.pointee.sa_family == UInt8(AF_INET) else {
                ptr = interface.ifa_next
                continue
            }
            
            let ifaName = String(cString: interface.ifa_name)
            
            guard ifaName == "en0" else {
                ptr = interface.ifa_next
                continue
            }
            
            // Network interface
            var addr = interface.ifa_addr.pointee
            var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
            
            getnameinfo(&addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                        &hostname, socklen_t(hostname.count),
                        nil, socklen_t(0), NI_NUMERICHOST)
            
            networkinterface = String(cString: hostname)
            
            // Subnet mask
            if let netmask = interface.ifa_netmask {
                var netmaskAddr = netmask.pointee
                var netmaskHost = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                
                getnameinfo(&netmaskAddr, socklen_t(netmaskAddr.sa_len),
                            &netmaskHost, socklen_t(netmaskHost.count),
                            nil, socklen_t(0), NI_NUMERICHOST)
                
                subnetMask = String(cString: netmaskHost)
            }
            
            // Router IP (gateway)
            if let dstAddr = interface.ifa_dstaddr {
                var dstAddr = dstAddr.pointee
                var dstHostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                
                getnameinfo(&dstAddr, socklen_t(dstAddr.sa_len),
                            &dstHostname, socklen_t(dstHostname.count),
                            nil, socklen_t(0), NI_NUMERICHOST)
                
                router = String(cString: dstHostname)
            }
            
            ptr = interface.ifa_next
        }
        
        freeifaddrs(ifaddr)
    }
}
