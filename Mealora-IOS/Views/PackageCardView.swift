//
//  PackageCardView.swift
//  Mealora-IOS
//
//  Created by Mahamed Adan on 2026-01-29.
//

import Foundation
import SwiftUI

struct PackageCardView: View {
    let package: Package
    let onActivate: () -> Void
    let onUseMeal: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(package.offer.restaurantName)
                .font(.headline)

            Text("Måltider kvar: \(package.mealsLeft)")

            Text(package.isActivated ? "Aktiverat" : "Ej aktiverat")
                .foregroundColor(package.isActivated ? .green : .red)

            if !package.isActivated {
                Button("Aktivera paket") {
                    onActivate()
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding(.vertical, 8)
        
        if package.isActivated && package.mealsLeft > 0 {
            Button("Använd 1 måltid") {
                onUseMeal()
            }
            .buttonStyle(.bordered)
        }
    }
   

}
