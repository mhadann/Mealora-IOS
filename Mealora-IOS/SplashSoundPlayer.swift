//
//  SplashSoundPlayer.swift
//  Mealora-IOS
//
//  Created by Mahamed Adan on 2026-02-6.
//

import AVFoundation

final class SplashSoundPlayer {

    static let shared = SplashSoundPlayer()
    private var player: AVAudioPlayer?

    private init() {}

    func play() {
        guard let url = Bundle.main.url(forResource: "splash", withExtension: "wav") else {
            print(" splash.wav saknas")
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            player?.play()
        } catch {
            print(" Kunde inte spela ljud:", error)
        }
    }
}
