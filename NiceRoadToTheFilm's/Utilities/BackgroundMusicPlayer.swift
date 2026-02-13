//
//  BackgroundMusicPlayer.swift
//  NiceRoadToTheFilm's
//
//  Created by Ivan Solohub on 13.02.2026.
//

import Foundation
import AVFoundation

final class BackgroundMusicPlayer {

    static let shared = BackgroundMusicPlayer()

    private var player: AVAudioPlayer?
    private var isConfigured = false

    private init() {}

    func apply(isEnabled: Bool) {
        if isEnabled {
            start()
        } else {
            stop()
        }
    }

    // MARK: - Private

    private func configureSessionIfNeeded() {
        guard !isConfigured else { return }
        isConfigured = true

        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient, options: [.mixWithOthers])
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Audio session error:", error.localizedDescription)
        }
    }

    private func start() {
        configureSessionIfNeeded()

        guard player == nil else {
            player?.play()
            return
        }

        guard let url = Bundle.main.url(forResource: "backgroundMusic", withExtension: "mp3") else {
            print("background_music.mp3 not found in bundle")
            return
        }

        do {
            let p = try AVAudioPlayer(contentsOf: url)
            p.numberOfLoops = -1
            p.volume = 0.5
            p.prepareToPlay()
            p.play()
            player = p
        } catch {
            print("AVAudioPlayer error:", error.localizedDescription)
        }
    }

    private func stop() {
        player?.stop()
        player = nil
    }
}
