import ScrechKit
@preconcurrency import MultipeerConnectivity

struct MPCSessionConstants {
    nonisolated(unsafe) static let kKeyIdentity = "identity"
}

class MPCSession: NSObject, MCSessionDelegate, MCNearbyServiceBrowserDelegate, MCNearbyServiceAdvertiserDelegate {
    var peerDataHandler: (@MainActor (Data, MCPeerID) -> Void)?
    var peerConnectedHandler: (@MainActor (MCPeerID) -> Void)?
    var peerDisconnectedHandler: (@MainActor (MCPeerID) -> Void)?
    var failureHandler: (@MainActor (String) -> Void)?
    
    private nonisolated let serviceString: String
    private nonisolated(unsafe) let mcSession: MCSession
    private let localPeerID = MCPeerID(displayName: UIDevice.current.name)
    private let mcAdvertiser: MCNearbyServiceAdvertiser
    private let mcBrowser: MCNearbyServiceBrowser
    private nonisolated let identityString: String
    private nonisolated let maxNumPeers: Int
    
    init(service: String, identity: String, maxPeers: Int) {
        serviceString = service
        identityString = identity
        mcSession = MCSession(peer: localPeerID, securityIdentity: nil, encryptionPreference: .required)
        
        mcAdvertiser = MCNearbyServiceAdvertiser(
            peer: localPeerID,
            discoveryInfo: [MPCSessionConstants.kKeyIdentity: identityString],
            serviceType: serviceString
        )
        
        mcBrowser = MCNearbyServiceBrowser(peer: localPeerID, serviceType: serviceString)
        maxNumPeers = maxPeers
        
        super.init()
        mcSession.delegate = self
        mcAdvertiser.delegate = self
        mcBrowser.delegate = self
    }
    
    // MARK: - `MPCSession` public methods
    func start() {
        mcAdvertiser.startAdvertisingPeer()
        mcBrowser.startBrowsingForPeers()
    }
    
    func suspend() {
        mcAdvertiser.stopAdvertisingPeer()
        mcBrowser.stopBrowsingForPeers()
    }
    
    func invalidate() {
        suspend()
        mcSession.disconnect()
    }
    
    func sendDataToAllPeers(data: Data) {
        sendData(data: data, peers: mcSession.connectedPeers, mode: .reliable)
    }
    
    func sendData(data: Data, peers: [MCPeerID], mode: MCSessionSendDataMode) {
        do {
            try mcSession.send(data, toPeers: peers, with: mode)
        } catch let error {
            NSLog("Error sending data: \(error)")
        }
    }
    
    // MARK: - `MPCSession` private methods
    private func peerConnected(peerID: MCPeerID) {
        if let handler = peerConnectedHandler {
            handler(peerID)
        }
        
        if mcSession.connectedPeers.count == maxNumPeers {
            suspend()
        }
    }
    
    private func peerDisconnected(peerID: MCPeerID) {
        if let handler = peerDisconnectedHandler {
            handler(peerID)
        }
        
        if mcSession.connectedPeers.count < maxNumPeers {
            start()
        }
    }
    
    private func handleSessionStateChange(_ state: MCSessionState, peerID: MCPeerID) {
        switch state {
        case .connected:
            peerConnected(peerID: peerID)
            
        case .notConnected:
            peerDisconnected(peerID: peerID)
            
        case .connecting:
            break
            
        @unknown default:
            assertionFailure("Unhandled MCSessionState")
        }
    }
    
    private func handleReceivedData(_ data: Data, from peerID: MCPeerID) {
        peerDataHandler?(data, peerID)
    }
    
    private func handleBrowsingFailure() {
        failureHandler?("Unable to browse for peers, check Local Network access")
    }
    
    private func handleAdvertisingFailure() {
        failureHandler?("Unable to advertise peer, check Local Network access")
    }
    
    private nonisolated func handleFoundPeer(
        _ peerID: MCPeerID,
        browser: MCNearbyServiceBrowser,
        info: [String: String]?
    ) {
        guard let identityValue = info?[MPCSessionConstants.kKeyIdentity] else {
            return
        }
        
        let isConnectedToPeer = mcSession.connectedPeers.contains { $0 == peerID }
        
        if identityValue == identityString && !isConnectedToPeer && mcSession.connectedPeers.count < maxNumPeers {
            browser.invitePeer(peerID, to: mcSession, withContext: nil, timeout: 10)
        }
    }
    
    // MARK: - `MCSessionDelegate`
    nonisolated internal func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        Task { @MainActor [weak self] in
            self?.handleSessionStateChange(state, peerID: peerID)
        }
    }
    
    nonisolated internal func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        Task { @MainActor [weak self] in
            self?.handleReceivedData(data, from: peerID)
        }
    }
    
    nonisolated internal func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        // The sample app intentional omits this implementation
    }
    
    nonisolated internal func session(_ session: MCSession,
                                      didStartReceivingResourceWithName resourceName: String,
                                      fromPeer peerID: MCPeerID,
                                      with progress: Progress) {
        // The sample app intentional omits this implementation
    }
    
    nonisolated internal func session(
        _ session: MCSession,
        didFinishReceivingResourceWithName resourceName: String,
        fromPeer peerID: MCPeerID,
        at localURL: URL?,
        withError error: Error?
    ) {
        // The sample app intentional omits this implementation
    }
    
    // MARK: - `MCNearbyServiceBrowserDelegate`.
    nonisolated internal func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String: String]?) {
        handleFoundPeer(peerID, browser: browser, info: info)
    }
    
    nonisolated internal func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        // The sample app intentional omits this implementation
    }
    
    nonisolated internal func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: any Error) {
        Task { @MainActor [weak self] in
            self?.handleBrowsingFailure()
        }
    }
    
    // MARK: - `MCNearbyServiceAdvertiserDelegate`
    nonisolated internal func advertiser(
        _ advertiser: MCNearbyServiceAdvertiser,
        didReceiveInvitationFromPeer peerID: MCPeerID,
        withContext context: Data?,
        invitationHandler: @escaping (Bool, MCSession?) -> Void
    ) {
        if mcSession.connectedPeers.count < maxNumPeers {
            invitationHandler(true, mcSession)
        } else {
            invitationHandler(false, nil)
        }
    }
    
    nonisolated internal func advertiser(
        _ advertiser: MCNearbyServiceAdvertiser,
        didNotStartAdvertisingPeer error: any Error
    ) {
        Task { @MainActor [weak self] in
            self?.handleAdvertisingFailure()
        }
    }
}
