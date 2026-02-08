//
//  PaymentSuccessView.swift
//  Mealora-IOS
//
//  Created by Mahamed Adan on 2026-02-08.
//

import SwiftUI

struct PaymentSuccessView: View {
    let text: String
    let onDone: () -> Void

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.green)

            Text(text)
                .font(.title2)
                .fontWeight(.semibold)

            Spacer()

            Button("Klar") {
                onDone()
            }
            .buttonStyle(.borderedProminent)
            .padding(.bottom, 40)
        }
        .padding()
    }
}
