import Foundation

@Observable
final class RouterVM {
    private let RTAX_GATEWAY = 1
    private let RTAX_MAX = 8
    
    private struct rt_metrics {
        public let rmx_locks:    UInt32 // Kernel leaves these values alone
        public let rmx_mtu:      UInt32 // MTU for this path
        public let rmx_hopcount: UInt32 // max hops expected
        public let rmx_expire:   Int32 // lifetime for route, e.g. redirect
        public let rmx_recvpipe: UInt32 // inbound delay-bandwidth product
        public let rmx_sendpipe: UInt32 // outbound delay-bandwidth product
        public let rmx_ssthresh: UInt32 // outbound gateway buffer limit
        public let rmx_rtt:      UInt32 // estimated round trip time
        public let rmx_rttvar:   UInt32 // estimated rtt variance
        public let rmx_pksent:   UInt32 // packets sent using this route
        public let rmx_state:    UInt32 // route state
        public let rmx_filler:   (UInt32, UInt32, UInt32) // will be used for TCP's peer-MSS cache
    }
    
    private struct rt_msghdr2 {
        public let rtm_msglen:      u_short // to skip over non-understood messages
        public let rtm_version:     u_char // future binary compatibility
        public let rtm_type:        u_char // message type
        public let rtm_index:       u_short // index for associated ifp
        public let rtm_flags:       Int32 // flags, incl. kern & message, e.g. DONE
        public let rtm_addrs:       Int32 // bitmask identifying sockaddrs in msg
        public let rtm_refcnt:      Int32 // reference count
        public let rtm_parentflags: Int32 // flags of the parent route
        public let rtm_reserved:    Int32 // reserved field set to 0
        public let rtm_use:         Int32 // from rtentry
        public let rtm_inits:       UInt32 // which metrics we are initializing
        public let rtm_rmx:         rt_metrics // metrics themselves
    }
    
    func fetch() -> String? {
        var name = [CTL_NET, PF_ROUTE, 0, 0, NET_RT_DUMP2, 0]
        
        let nameSize = u_int(name.count)
        
        var bufferSize = 0
        sysctl(&name, nameSize, nil, &bufferSize, nil, 0)
        
        let buffer = UnsafeMutablePointer<UInt8>.allocate(capacity: bufferSize)
        
        defer {
            buffer.deallocate()
        }
        
        buffer.initialize(repeating: 0, count: bufferSize)
        
        guard sysctl(&name, nameSize, buffer, &bufferSize, nil, 0) == 0 else {
            return nil
        }
        
        // Routes
        var rt = buffer
        let end = rt.advanced(by: bufferSize)
        
        while rt < end {
            let msg = rt.withMemoryRebound(to: rt_msghdr2.self, capacity: 1) {
                $0.pointee
            }
            
            // Addresses
            var addr = rt.advanced(by: MemoryLayout<rt_msghdr2>.stride)
            
            for i in 0..<RTAX_MAX {
                if (msg.rtm_addrs & (1 << i)) != 0 && i == RTAX_GATEWAY {
                    let si = addr.withMemoryRebound(to: sockaddr_in.self, capacity: 1) {
                        $0.pointee
                    }
                    
                    if si.sin_addr.s_addr == INADDR_ANY {
                        return "default"
                    } else if let pointer = inet_ntoa(si.sin_addr) {
                        return String.decodeCString(pointer)
                    }
                    
                    return nil
                }
                
                let sa = addr.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                    $0.pointee
                }
                
                addr = addr.advanced(by: Int(sa.sa_len))
            }
            
            rt = rt.advanced(by: Int(msg.rtm_msglen))
        }
        
        return nil
    }
}
