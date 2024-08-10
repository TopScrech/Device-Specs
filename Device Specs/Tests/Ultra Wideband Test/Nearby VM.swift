#if canImport(NearbyInteraction)
import SwiftUI
import NearbyInteraction
import MultipeerConnectivity

@Observable
class NearbyVM: NSObject, NISessionDelegate {
    var monkeyLabel = "🙈"
    var connectedDeviceName = ""
    var status = ""
    
    var distance = ""
    var azimuthText = ""
    var elevationText = ""
    var monkeyRotationAngle: CGFloat = 0
    
    var leftArrow: CGFloat = 0
    var rightArrow: CGFloat = 0
    var upArrow: CGFloat = 0
    var downArrow: CGFloat = 0
    var angleInfoView: CGFloat = 0
    
    let nearbyDistanceThreshold: Float = 0.3
    
    enum DistanceDirectionState {
        case closeUpInFOV, notCloseUpInFOV, outOfFOV, unknown
    }
    
    // MARK: - Alert
    var showAlert = false
    var alertTitle = ""
    var alertMessage = ""
    
    // MARK: - Class variables
    var session: NISession?
    var peerDiscoveryToken: NIDiscoveryToken?
    let impactGenerator = UIImpactFeedbackGenerator(style: .medium)
    var currentDistanceDirectionState: DistanceDirectionState = .unknown
    var mpc: MPCSession?
    var connectedPeer: MCPeerID?
    var sharedTokenWithPeer = false
    var peerDisplayName: String?
    
    override init() {
        super.init()
        startup()
    }
    
    func startup() {
        session = NISession()
        session?.delegate = self
        // Because the session is new, reset the token-shared flag
        sharedTokenWithPeer = false
        
        // If `connectedPeer` exists, share the discovery token, if needed
        if connectedPeer != nil && mpc != nil {
            if let myToken = session?.discoveryToken {
                updateInformationLabel("Initializing ...")
                
                if !sharedTokenWithPeer {
                    shareMyDiscoveryToken(token: myToken)
                }
                
                guard let peerToken = peerDiscoveryToken else {
                    return
                }
                
                let config = NINearbyPeerConfiguration(peerToken: peerToken)
                session?.run(config)
            } else {
                fatalError("Unable to get self discovery token, is this session invalidated?")
            }
        } else {
            updateInformationLabel("Discovering Peer...")
            startupMPC()
            
            // Set the display state
            currentDistanceDirectionState = .unknown
        }
    }
    
    // MARK: - `NISessionDelegate`
    func session(_ session: NISession, didUpdate nearbyObjects: [NINearbyObject]) {
        guard let peerToken = peerDiscoveryToken else {
            fatalError("don't have peer token")
        }
        
        // Find the right peer
        let peerObj = nearbyObjects.first { obj -> Bool in
            obj.discoveryToken == peerToken
        }
        
        guard let nearbyObjectUpdate = peerObj else {
            return
        }
        
        // Update the the state and visualizations
        let nextState = getDistanceDirectionState(from: nearbyObjectUpdate)
        updateVisualization(from: currentDistanceDirectionState, to: nextState, with: nearbyObjectUpdate)
        currentDistanceDirectionState = nextState
    }
    
    func session(_ session: NISession, didRemove nearbyObjects: [NINearbyObject], reason: NINearbyObject.RemovalReason) {
        guard let peerToken = peerDiscoveryToken else {
            fatalError("don't have peer token")
        }
        
        // Find the right peer
        let peerObj = nearbyObjects.first { obj -> Bool in
            obj.discoveryToken == peerToken
        }
        
        if peerObj == nil {
            return
        }
        
        currentDistanceDirectionState = .unknown
        
        switch reason {
        case .peerEnded:
            peerDiscoveryToken = nil
            
            session.invalidate()
            
            startup()
            
            updateInformationLabel("Peer Ended")
            
        case .timeout:
            if let config = session.configuration {
                session.run(config)
            }
            
            updateInformationLabel("Peer Timeout")
            
        default:
            fatalError("Unknown and unhandled NINearbyObject.RemovalReason")
        }
    }
    
    func sessionWasSuspended(_ session: NISession) {
        currentDistanceDirectionState = .unknown
        updateInformationLabel("Session suspended")
    }
    
    func sessionSuspensionEnded(_ session: NISession) {
        // Session suspension ended. The session can now be run again
        if let config = self.session?.configuration {
            session.run(config)
        } else {
            startup()
        }
        
        connectedDeviceName = peerDisplayName ?? ""
    }
    
    func session(_ session: NISession, didInvalidateWith error: Error) {
        currentDistanceDirectionState = .unknown
        
        if case NIError.userDidNotAllow = error {
            updateInformationLabel("Nearby Interactions access required. You can change access in Settings.")
            alertTitle = "Access Required"
            alertMessage = "NIPeekaboo requires access to Nearby Interactions. Update this in Settings."
            showAlert = true
            return
        }
        // If the app lacks user approval for Nearby Interaction, present
        // an option to go to Settings where the user can update the access
        //        if case NIError.userDidNotAllow = error {
        //            if #available(iOS 15, *) {
        //                // In iOS 15.0, Settings persists Nearby Interaction access
        //                updateInformationLabel("Nearby Interactions access required. You can change access for NIPeekaboo in Settings.")
        //                // Create an alert that directs the user to Settings
        //                let accessAlert = UIAlertController(title: "Access Required",
        //                                                    message: """
        //                                                    NIPeekaboo requires access to Nearby Interactions for this sample app.
        //                                                    Use this string to explain to users which functionality will be enabled if they change
        //                                                    Nearby Interactions access in Settings.
        //                                                    """,
        //                                                    preferredStyle: .alert)
        //                accessAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        //                accessAlert.addAction(UIAlertAction(title: "Go to Settings", style: .default) {_ in
        //                    // Send the user to the app's Settings to update Nearby Interactions access
        //                    if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
        //                        UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
        //                    }
        //                })
        //
        //                // Display the alert
        //                present(accessAlert, animated: true, completion: nil)
        //            } else {
        //                // Before iOS 15.0, ask the user to restart the app so the
        //                // framework can ask for Nearby Interaction access again
        //                updateInformationLabel("Nearby Interactions access required. Restart NIPeekaboo to allow access")
        //            }
        //
        //            return
        //        }
        
        startup()
    }
    
    // MARK: - Discovery token sharing and receiving using MPC
    func startupMPC() {
        if mpc == nil {
            // Prevent Simulator from finding devices
#if targetEnvironment(simulator)
            mpc = MPCSession(service: "nisample", identity: "com.example.apple-samplecode.simulator.peekaboo-nearbyinteraction", maxPeers: 1)
#else
            mpc = MPCSession(service: "nisample", identity: "com.example.apple-samplecode.peekaboo-nearbyinteraction", maxPeers: 1)
#endif
            mpc?.peerConnectedHandler = connectedToPeer
            mpc?.peerDataHandler = dataReceivedHandler
            mpc?.peerDisconnectedHandler = disconnectedFromPeer
        }
        
        mpc?.invalidate()
        mpc?.start()
    }
    
    func connectedToPeer(peer: MCPeerID) {
        guard let myToken = session?.discoveryToken else {
            fatalError("Unexpectedly failed to initialize nearby interaction session")
        }
        
        if connectedPeer != nil {
            fatalError("Already connected to a peer")
        }
        
        if !sharedTokenWithPeer {
            shareMyDiscoveryToken(token: myToken)
        }
        
        connectedPeer = peer
        peerDisplayName = peer.displayName
        
        connectedDeviceName = peerDisplayName ?? ""
    }
    
    func disconnectedFromPeer(_ peer: MCPeerID) {
        if connectedPeer == peer {
            connectedPeer = nil
            sharedTokenWithPeer = false
        }
    }
    
    func dataReceivedHandler(data: Data, peer: MCPeerID) {
        guard let discoveryToken = try? NSKeyedUnarchiver.unarchivedObject(ofClass: NIDiscoveryToken.self, from: data) else {
            fatalError("Unexpectedly failed to decode discovery token.")
        }
        
        peerDidShareDiscoveryToken(peer: peer, token: discoveryToken)
    }
    
    func shareMyDiscoveryToken(token: NIDiscoveryToken) {
        guard let encodedData = try?  NSKeyedArchiver.archivedData(withRootObject: token, requiringSecureCoding: true) else {
            fatalError("Unexpectedly failed to encode discovery token.")
        }
        
        mpc?.sendDataToAllPeers(data: encodedData)
        sharedTokenWithPeer = true
    }
    
    func peerDidShareDiscoveryToken(peer: MCPeerID, token: NIDiscoveryToken) {
        if connectedPeer != peer {
            fatalError("Received token from unexpected peer.")
        }
        // Create a configuration
        peerDiscoveryToken = token
        
        let config = NINearbyPeerConfiguration(peerToken: token)
        
        session?.run(config)
    }
    
    // MARK: - Visualizations
    func isNearby(_ distance: Float) -> Bool {
        distance < nearbyDistanceThreshold
    }
    
    func isPointingAt(_ angleRad: Float) -> Bool {
        // Consider the range -15 to +15 to be "pointing at"
        abs(angleRad.radiansToDegrees) <= 15
    }
    
    func getDistanceDirectionState(from nearbyObject: NINearbyObject) -> DistanceDirectionState {
        if nearbyObject.distance == nil && nearbyObject.direction == nil {
            return .unknown
        }
        
        let isNearby = nearbyObject.distance.map(isNearby(_:)) ?? false
        let directionAvailable = nearbyObject.direction != nil
        
        if isNearby && directionAvailable {
            return .closeUpInFOV
        }
        
        if !isNearby && directionAvailable {
            return .notCloseUpInFOV
        }
        
        return .outOfFOV
    }
    
    private func animate(from currentState: DistanceDirectionState, to nextState: DistanceDirectionState, with peer: NINearbyObject) {
        let azimuth = peer.direction.map(azimuth(from:))
        let elevation = peer.direction.map(elevation(from:))
        
        connectedDeviceName = peerDisplayName ?? ""
        
        // If the app transitions from unavailable, present the app's display
        // and hide the user instructions
        if nextState == .outOfFOV || nextState == .unknown {
            angleInfoView = 0
        } else {
            angleInfoView = 1
        }
        
        // Set the app's display based on peer state
        switch nextState {
        case .closeUpInFOV:
            monkeyLabel = "🙉"
            
        case .notCloseUpInFOV:
            monkeyLabel = "🙈"
            
        case .outOfFOV:
            monkeyLabel = "🙊"
            
        case .unknown:
            monkeyLabel = ""
        }
        
        if peer.distance != nil {
            distance = String(format: "%0.2f m", peer.distance!)
        }
        
        monkeyRotationAngle = CGFloat(azimuth ?? 0)
        
        // Don't update visuals if the peer device is unavailable or out of the field of view
        if nextState == .outOfFOV || nextState == .unknown {
            return
        }
        
        if elevation != nil {
            if elevation! < 0 {
                downArrow = 1
                upArrow = 0
            } else {
                downArrow = 0
                upArrow = 1
            }
            
            elevationText = String(format: "% 3.0f°", elevation!.radiansToDegrees)
        }
        
        if azimuth != nil {
            if isPointingAt(azimuth!) {
                leftArrow = 0.25
                rightArrow = 0.25
            } else {
                if azimuth! < 0 {
                    leftArrow = 1
                    rightArrow = 0.25
                } else {
                    leftArrow = 0.25
                    rightArrow = 1
                }
            }
            
            azimuthText = String(format: "% 3.0f°", azimuth!.radiansToDegrees)
        }
    }
    
    func updateVisualization(from currentState: DistanceDirectionState, to nextState: DistanceDirectionState, with peer: NINearbyObject) {
        if currentState == .notCloseUpInFOV && nextState == .closeUpInFOV || currentState == .unknown {
            impactGenerator.impactOccurred()
        }
        
        withAnimation(.easeOut(duration: 0.3)) {
            animate(from: currentState, to: nextState, with: peer)
        }
    }
    
    func updateInformationLabel(_ description: String) {
        withAnimation(.easeOut(duration: 0.3)) {
            status = description
        }
    }
}

#endif
