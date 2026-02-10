//
//  PaymentSuccessView.swift
//  Mealora-IOS
//
//  Created by Mahamed Adan on 2026-01-20.
//

import SwiftUI
import AudioToolbox


struct PaymentSuccessView: View {
    let text: String
    let isSuccess: Bool
    let onDone: () -> Void

    var body: some View {
        VStack(spacing: 24) {
            Image(systemName: isSuccess
                  ? "checkmark.circle.fill"
                  : "xmark.octagon.fill")
                .font(.system(size: 90))
                .foregroundColor(isSuccess ? .green : .red)

            Text(text)
                .font(.title.bold())

            Button("Klar") {
                onDone()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .onAppear {
            playSound()
        }
    }

    private func playSound() {
        if isSuccess {
            AudioServicesPlaySystemSound(1013) // godkänt‑pling
        } else {
            AudioServicesPlaySystemSound(1006) // error‑ljud
        }
    }
}
