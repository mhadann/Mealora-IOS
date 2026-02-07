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
    let index: Int
    
    @ObservedObject var packagesVM: MyPackagesViewModel
    @State private var showQRScanner = false
    @State private var qrAction: QRAction?
    
    enum QRAction {
        case activate
        case useMeal
    }


    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(package.offer.restaurantName)
                .font(.headline)

            Text("Måltider kvar: \(package.mealsLeft)")

            Text(package.isActivated ? "Aktiverat" : "Ej aktiverat")
                .foregroundColor(package.isActivated ? .green : .red)

            if !package.isActivated {
                Button("Aktivera paket") {
                       qrAction = .activate
                       showQRScanner = true
                   }
                .sheet(isPresented: $showQRScanner) {
                    QRScannerView(onScan: { scannedCode in
                        handleScan(scannedCode)
                    })
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding(.vertical, 8)
        
        if package.isActivated && package.mealsLeft > 0 {
            Button("Använd måltid") {
                    qrAction = .useMeal
                    showQRScanner = true
                }
            .sheet(isPresented: $showQRScanner) {
                QRScannerView(onScan: { scannedCode in
                    handleScan(scannedCode)
                })
            }
            .buttonStyle(.bordered)
        }
    }
   

    func handleScan(_ scannedCode: String) {
        guard let action = qrAction else { return }

        switch action {
        case .activate:
            packagesVM.activatePackage(
                at: index,
                scannedCode: scannedCode
            )

        case .useMeal:
            packagesVM.useMeal(
                at: index,
                scannedCode: scannedCode
            )
        }

        showQRScanner = false
        qrAction = nil
    }

}
