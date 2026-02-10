//
//  SplashView.swift
//  Mealora-IOS
//
//  Created by Mahamed Adan on 2026-01-31.
//

import SwiftUI
import AVFoundation

struct SplashView: View {

    @State private var scale: CGFloat = 0.6
    @State private var opacity: Double = 0
    @State private var glow: Double = 0
    @State private var moveUp: CGFloat = 20
    @State private var showContent = false

    private let player = SplashSoundPlayer.shared

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()

            if !showContent {
                VStack(spacing: 8) {
                    Text("Mealora")
                        .font(.system(size: 48, weight: .bold))
                        .foregroundColor(foodoraPink)
                        .scaleEffect(scale)
                        .opacity(opacity)
                        .shadow(
                            color: foodoraPink.opacity(glow),
                            radius: 20
                        )

                    Text("eat more, save more ")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .opacity(opacity)
                        .offset(y: moveUp)
                }
            } else {
                ContentView() // 🚀 din app startar här
            }
        }
        .onAppear {
            startAnimation()
        }
    }

    private func startAnimation() {
        player.play()

        // 1️⃣ Fade + scale in
        withAnimation(.easeOut(duration: 0.6)) {
            opacity = 1
            scale = 1.0
        }

        // 2️⃣ Glow pulse
        withAnimation(
            .easeInOut(duration: 0.8)
            .repeatCount(2, autoreverses: true)
        ) {
            glow = 0.6
        }

        // 3️⃣ Subtitle slide
        withAnimation(.spring(response: 0.7, dampingFraction: 0.8)) {
            moveUp = 0
        }

        // 4️⃣ Exit to app
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
            withAnimation(.easeInOut(duration: 0.4)) {
                opacity = 0
                scale = 1.1
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                showContent = true
            }
        }
    }
}
