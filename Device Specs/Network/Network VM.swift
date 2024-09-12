import Foundation

@Observable
final class NetworkVM {
    var address = ""
    var router = ""
    
    func getIPAddresses() {
        var deviceIP: String?
        var routerIP: String?
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
                        
                        deviceIP = String(cString: hostname)
                    }
                    
                    if ifaName == "en0", interface.ifa_dstaddr != nil {
                        var addr = interface.ifa_dstaddr.pointee
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        
                        getnameinfo(&addr, socklen_t(interface.ifa_dstaddr.pointee.sa_len),
                                    &hostname, socklen_t(hostname.count),
                                    nil, socklen_t(0), NI_NUMERICHOST)
                        
                        routerIP = String(cString: hostname)
                    }
                }
                
                ptr = interface.ifa_next
            }
        }
        
        freeifaddrs(ifaddr)
        
        address = deviceIP ?? "-"
        router = routerIP ?? "-"
    }
}
