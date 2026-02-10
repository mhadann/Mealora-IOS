//
//  QRScannerOverlayView.swift .swift
//  Mealora-IOS
//
//  Created by Mahamed Adan on 2026-02-10.
//

import SwiftUI

struct QRScannerOverlayView: View {

    var body: some View {
        ZStack {
            // Mörk overlay
            Color.black.opacity(0.55)
                .ignoresSafeArea()

            VStack {
                Spacer()

                // Scanner-rutan
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.white, lineWidth: 2)
                        .frame(width: 260, height: 260)

                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.clear)
                        .frame(width: 260, height: 260)
                        .background(
                            Color.black
                                .blendMode(.destinationOut)
                        )
                }

                Spacer()

                // Instruktion
                Text("Rikta kameran mot QR‑koden")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.bottom, 40)
            }
        }
        .compositingGroup()
    }
}


#Preview {
    QRScannerOverlayView()
}
