import Foundation

@Observable
final class NetworkVM {
    func getIPAddress() -> String? {
        var address: String?
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        
        if getifaddrs(&ifaddr) == 0 {
            var ptr = ifaddr
            
            while ptr != nil {
                let interface = ptr!.pointee
                
                if interface.ifa_addr.pointee.sa_family == UInt8(AF_INET) {
                    let ifaName = String(cString: interface.ifa_name)
                    
                    if ifaName == "en0" {
                        var addr = interface.ifa_addr.pointee
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        
                        getnameinfo(&addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                                    &hostname, socklen_t(hostname.count),
                                    nil, socklen_t(0), NI_NUMERICHOST)
                        
                        address = String(cString: hostname)
                        
                        break
                    }
                }
                
                ptr = interface.ifa_next
            }
        }
        
        freeifaddrs(ifaddr)
        
        return address
    }
}
