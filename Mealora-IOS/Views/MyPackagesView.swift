//
//  MyPackagesView.swift
//  Mealora-IOS
//
//  Created by Mahamed Adan on 2026-01-29.
//

import SwiftUI

// View som visar paket listan

struct MyPackagesView: View {
    @EnvironmentObject var packagesVM: MyPackagesViewModel

    var body: some View {
        NavigationStack {
            List {
                if packagesVM.packages.isEmpty {
                    Text("Inga paket ännu")
                } else {
                    ForEach(packagesVM.packages) { package in
                        VStack(alignment: .leading, spacing: 8) {
                            Text(package.offer.restaurantName)
                                .font(.headline)

                            Text("Måltider kvar: \(package.mealsLeft)")

                            Text(package.isActivated ? "Aktiverat" : "Ej aktiverat")
                                .foregroundColor(package.isActivated ? .green : .red)
                        }
                        .padding(.vertical, 8)
                    }
                }
            }
            .navigationTitle("Mina paket")
        }
    }
}




