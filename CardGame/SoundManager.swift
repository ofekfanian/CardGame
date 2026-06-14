import AVFoundation

// MARK: SoundManager
class SoundManager {

    static let shared = SoundManager()
    private init() {}

    private var bgPlayer: AVAudioPlayer?
    private var sfxPlayers: [AVAudioPlayer] = []

    func playBackground() {
        guard let url = Bundle.main.url(forResource: "background", withExtension: "mp3") else { return }
        bgPlayer = try? AVAudioPlayer(contentsOf: url)
        bgPlayer?.numberOfLoops = -1
        bgPlayer?.volume = 0.35
        bgPlayer?.play()
    }

    func pauseBackground() {
        bgPlayer?.pause()
    }

    func resumeBackground() {
        bgPlayer?.play()
    }

    func stopBackground() {
        bgPlayer?.stop()
        bgPlayer = nil
    }

    func playFlip() {
        playSFX("card_flip")
    }

    func playWin() {
        playSFX("win")
    }

    private func playSFX(_ name: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else { return }
        guard let player = try? AVAudioPlayer(contentsOf: url) else { return }
        sfxPlayers.append(player)
        player.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + player.duration + 0.5) { [weak self] in
            self?.sfxPlayers.removeAll { $0 === player }
        }
    }
}
