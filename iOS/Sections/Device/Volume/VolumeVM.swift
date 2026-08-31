import AVFAudio
import Observation

@Observable
final class VolumeVM {
    private(set) var isVolumeSectionVisible = true
    
    init() {
        updateVolumeSectionVisibility()
    }
    
    func observeRouteChanges() async {
        for await _ in NotificationCenter.default.notifications(named: AVAudioSession.routeChangeNotification) {
            guard !Task.isCancelled else { return }
            updateVolumeSectionVisibility()
        }
    }
    
    private func updateVolumeSectionVisibility() {
        isVolumeSectionVisible = !AVAudioSession.sharedInstance().currentRoute.outputs.contains {
            $0.portType == .carAudio
        }
    }
}
