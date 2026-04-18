#if canImport(NearbyInteraction)
import SwiftUI
@preconcurrency import NearbyInteraction
@preconcurrency import MultipeerConnectivity
import OSLog

@Observable
class NearbyVM: NSObject, NISessionDelegate {
    private struct NearbyObjectsBox: @unchecked Sendable {
        nonisolated(unsafe) let value: [NINearbyObject]
        
        nonisolated init(value: [NINearbyObject]) {
            self.value = value
        }
    }
    
    private let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "DeviceSpecs", category: "NearbyVM")
    private(set) var monkeyLabel = "🙈"
    private(set) var connectedDeviceName = ""
    private(set) var status = ""
    
    private(set) var distance = ""
    private(set) var azimuthText = ""
    private(set) var elevationText = ""
    private(set) var monkeyRotationAngle = 0.0
    
    private(set) var leftArrow = 0.0
    private(set) var rightArrow = 0.0
    private(set) var upArrow = 0.0
    private(set) var downArrow = 0.0
    private(set) var angleInfoView = 0.0
    
    private let nearbyDistanceThreshold: Float = 0.3
    private let supportsPreciseDistanceMeasurement = NISession.deviceCapabilities.supportsPreciseDistanceMeasurement
    
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
    var pendingPeerToken: (peer: MCPeerID, token: NIDiscoveryToken)?
    private var isStopping = false
    
    override init() {
        super.init()
        startup()
        logger.info("UWB init")
    }
    
    private func startup() {
        isStopping = false
        session = NISession()
        session?.delegate = self
        
        // Because the session is new, reset the token-shared flag
        sharedTokenWithPeer = false
        
        // If `connectedPeer` exists, share the discovery token, if needed
        guard connectedPeer != nil && mpc != nil else {
            updateInformationLabel("Discovering peer")
            startupMPC()
            
            // Set the display state
            currentDistanceDirectionState = .unknown
            return
        }
        
        guard let myToken = session?.discoveryToken else {
            logger.error("Unable to get local discovery token")
            updateInformationLabel("Unable to start UWB session")
            return
        }
        
        updateInformationLabel("Initializing")
        
        if !sharedTokenWithPeer {
            shareMyDiscoveryToken(myToken)
        }
        
        guard let peerToken = peerDiscoveryToken else {
            return
        }
        
        let config = NINearbyPeerConfiguration(peerToken: peerToken)
        session?.run(config)
    }
    
    // MARK: - `NISessionDelegate`
    nonisolated func session(
        _ session: NISession,
        didUpdate nearbyObjects: [NINearbyObject]
    ) {
        let nearbyObjectsBox = NearbyObjectsBox(value: nearbyObjects)
        
        Task { @MainActor [weak self] in
            self?.handleSessionUpdate(nearbyObjectsBox.value)
        }
    }
    
    private func handleSessionUpdate(_ nearbyObjects: [NINearbyObject]) {
        guard let peerToken = peerDiscoveryToken else {
            return
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
        
        if nearbyObjectUpdate.distance != nil || nearbyObjectUpdate.direction != nil {
            updateInformationLabel("Ranging active")
        } else {
            updateInformationLabel("Ranging, but values are unavailable")
        }
    }
    
    nonisolated func session(
        _ session: NISession,
        didRemove nearbyObjects: [NINearbyObject],
        reason: NINearbyObject.RemovalReason
    ) {
        let nearbyObjectsBox = NearbyObjectsBox(value: nearbyObjects)
        
        Task { @MainActor [weak self] in
            self?.handleSessionRemoval(nearbyObjectsBox.value, reason: reason)
        }
    }
    
    private func handleSessionRemoval(
        _ nearbyObjects: [NINearbyObject],
        reason: NINearbyObject.RemovalReason
    ) {
        guard let peerToken = peerDiscoveryToken else {
            return
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
            pendingPeerToken = nil
            
            session?.invalidate()
            
            startup()
            
            updateInformationLabel("Peer Ended")
            
        case .timeout:
            if let config = session?.configuration {
                session?.run(config)
            }
            
            updateInformationLabel("Peer Timeout")
            
        @unknown default:
            logger.error("Unhandled nearby object removal reason")
            updateInformationLabel("Peer unavailable")
        }
    }
    
    nonisolated func sessionWasSuspended(_ session: NISession) {
        Task { @MainActor [weak self] in
            self?.handleSessionSuspended()
        }
    }
    
    private func handleSessionSuspended() {
        currentDistanceDirectionState = .unknown
        updateInformationLabel("Session suspended")
    }
    
    nonisolated func sessionSuspensionEnded(_ session: NISession) {
        Task { @MainActor [weak self] in
            self?.handleSessionSuspensionEnded()
        }
    }
    
    private func handleSessionSuspensionEnded() {
        // Session suspension ended. The session can now be run again
        if let config = session?.configuration, supportsPreciseDistanceMeasurement {
            session?.run(config)
        } else {
            startup()
        }
        
        connectedDeviceName = peerDisplayName ?? ""
    }
    
    nonisolated func session(_ session: NISession, didInvalidateWith error: Error) {
        Task { @MainActor [weak self] in
            self?.handleSessionInvalidation(error)
        }
    }
    
    private func handleSessionInvalidation(_ error: Error) {
        currentDistanceDirectionState = .unknown
        
        if isStopping {
            return
        }
        
        if case NIError.userDidNotAllow = error {
            updateInformationLabel("Nearby Interactions access required in Settings")
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
    private func startupMPC() {
        if mpc == nil {
            // Prevent Simulator from finding devices
#if targetEnvironment(simulator)
            let identity = "dev.topscrech.Device-Specs.simulator"
#else
            let identity = "dev.topscrech.Device-Specs"
#endif
            mpc = MPCSession(service: "specs", identity: identity, maxPeers: 1)
            mpc?.peerConnectedHandler = connectedToPeer
            mpc?.peerDataHandler = dataReceivedHandler
            mpc?.peerDisconnectedHandler = disconnectedFromPeer
            mpc?.failureHandler = mpcFailed
        }
        
        mpc?.invalidate()
        mpc?.start()
    }
    
    private func connectedToPeer(peer: MCPeerID) {
        guard let myToken = session?.discoveryToken else {
            logger.error("Missing discovery token while connecting to peer")
            updateInformationLabel("Unable to initialize UWB session")
            return
        }
        
        if connectedPeer != nil {
            logger.error("Ignoring duplicate peer connection for \(peer.displayName, privacy: .public)")
            return
        }
        
        connectedPeer = peer
        peerDisplayName = peer.displayName
        connectedDeviceName = peerDisplayName ?? ""
        updateInformationLabel("Connected to \(connectedDeviceName)")
        
        if !sharedTokenWithPeer {
            shareMyDiscoveryToken(myToken)
        }
        
        if let pendingPeerToken, pendingPeerToken.peer == peer {
            self.pendingPeerToken = nil
            peerDidShareDiscoveryToken(peer: peer, token: pendingPeerToken.token)
        }
    }
    
    private func disconnectedFromPeer(_ peer: MCPeerID) {
        if connectedPeer == peer {
            connectedPeer = nil
            sharedTokenWithPeer = false
            pendingPeerToken = nil
            peerDiscoveryToken = nil
            distance = ""
            azimuthText = ""
            elevationText = ""
            updateInformationLabel("Peer disconnected")
        }
    }
    
    private func dataReceivedHandler(data: Data, peer: MCPeerID) {
        guard
            let discoveryToken = try? NSKeyedUnarchiver.unarchivedObject(
                ofClass: NIDiscoveryToken.self,
                from: data
            )
        else {
            logger.error("Failed to decode discovery token from peer")
            return
        }
        
        updateInformationLabel("Received peer token")
        peerDidShareDiscoveryToken(peer: peer, token: discoveryToken)
    }
    
    private func shareMyDiscoveryToken(_ token: NIDiscoveryToken) {
        guard
            let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: token, requiringSecureCoding: true)
        else {
            logger.error("Failed to encode local discovery token")
            return
        }
        
        mpc?.sendDataToAllPeers(data: encodedData)
        sharedTokenWithPeer = true
        updateInformationLabel("Shared discovery token")
    }
    
    private func peerDidShareDiscoveryToken(peer: MCPeerID, token: NIDiscoveryToken) {
        guard connectedPeer != nil else {
            pendingPeerToken = (peer, token)
            updateInformationLabel("Waiting for peer handshake")
            return
        }
        
        guard connectedPeer == peer else {
            logger.error("Ignoring discovery token from unexpected peer: \(peer.displayName, privacy: .public)")
            updateInformationLabel("Ignoring unexpected peer token")
            return
        }
        
        // Create a configuration
        peerDiscoveryToken = token
        
        guard supportsPreciseDistanceMeasurement else {
            updateInformationLabel("UWB is unavailable on this device")
            return
        }
        
        let config = NINearbyPeerConfiguration(peerToken: token)
        
        session?.run(config)
        updateInformationLabel("Starting UWB session")
    }
    
    private func mpcFailed(_ message: String) {
        logger.error("\(message, privacy: .public)")
        updateInformationLabel(message)
    }
    
    // MARK: - Visualizations
    private func isNearby(_ distance: Float) -> Bool {
        distance < nearbyDistanceThreshold
    }
    
    private func isPointingAt(_ angleRad: Float) -> Bool {
        // Consider the range -15 to +15 to be "pointing at"
        abs(angleRad.radiansToDegrees) <= 15
    }
    
    private func getDistanceDirectionState(from nearbyObject: NINearbyObject) -> DistanceDirectionState {
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
        
        if let peerDistance = peer.distance {
            let clampedDistance = max(peerDistance, 0)
            distance = clampedDistance.formatted(.number.precision(.fractionLength(2))) + " m"
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
    
    private func updateVisualization(
        from currentState: DistanceDirectionState,
        to nextState: DistanceDirectionState,
        with peer: NINearbyObject
    ) {
        if currentState == .notCloseUpInFOV && nextState == .closeUpInFOV || currentState == .unknown {
            impactGenerator.impactOccurred()
        }
        
        withAnimation(.easeOut(duration: 0.3)) {
            animate(from: currentState, to: nextState, with: peer)
        }
    }
    
    private func updateInformationLabel(_ description: String) {
        withAnimation(.easeOut(duration: 0.3)) {
            status = description
        }
    }
    
    func stop() {
        guard !isStopping else {
            return
        }
        
        isStopping = true
        session?.delegate = nil
        session?.invalidate()
        session = nil
        
        mpc?.peerConnectedHandler = nil
        mpc?.peerDataHandler = nil
        mpc?.peerDisconnectedHandler = nil
        mpc?.failureHandler = nil
        mpc?.invalidate()
        mpc = nil
        
        peerDiscoveryToken = nil
        connectedPeer = nil
        peerDisplayName = nil
        pendingPeerToken = nil
        sharedTokenWithPeer = false
        currentDistanceDirectionState = .unknown
        connectedDeviceName = ""
        status = ""
        distance = ""
        azimuthText = ""
        elevationText = ""
        monkeyLabel = "🙈"
        monkeyRotationAngle = 0
        leftArrow = 0
        rightArrow = 0
        upArrow = 0
        downArrow = 0
        angleInfoView = 0
    }
}

#endif
