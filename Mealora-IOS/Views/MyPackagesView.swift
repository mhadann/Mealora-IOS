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
    @State private var showAlert = false
    @State private var selectedIndex: Int?

    var body: some View {
        NavigationStack {
            List {
                ForEach(packagesVM.packages.indices, id: \.self) { index in
                    PackageCardView(
                        package: packagesVM.packages[index],
                        onActivate: {
                            selectedIndex = index
                            showAlert = true
                        },
                        onUseMeal: {
                            packagesVM.useMeal(
                                at: index,
                                scannedCode: "bella-italia-qr" // mock QR
                            )
                        }
                    )
                }
            }
            .navigationTitle("Mina paket")
            .alert("Har du betalat paketet?", isPresented: $showAlert) {
                Button("Nej", role: .cancel) {}
                Button("Ja") {
                    activateMockQR()
                }
            }
        }
    }

    func activateMockQR() {
        guard let index = selectedIndex else { return }
        packagesVM.activatePackage(at: index, scannedCode: "bella-italia-qr")
    }
}
