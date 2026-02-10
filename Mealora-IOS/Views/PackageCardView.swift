//
//  PackageCardView.swift
//  Mealora-IOS
//
//  Created by Mahamed Adan on 2026-01-29.
//

import Foundation
import SwiftUI
import AudioToolbox


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

    @State private var showSuccessView = false
    @State private var successText = ""
    
    @State private var showResultView = false
    @State private var isSuccess = false



    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(package.offer.restaurantName)
                .font(.headline)

            Text("Måltider kvar: \(package.mealsLeft)")

            Text(package.isActivated ? "Aktiverat" : "Ej aktiverat")
                .foregroundColor(package.isActivated ? .green : .red)
            
            if package.isActivated, let daysLeft = package.daysLeft {
                Text("\(daysLeft) dagar kvar")
                    .font(.subheadline)
                    .foregroundColor(daysLeft <= 3 ? .red : .secondary)
            }


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
            .fullScreenCover(isPresented: $showSuccessView) {
                PaymentSuccessView(
                    text: successText,
                    isSuccess: isSuccess,
                    onDone: {
                        showSuccessView = false
                    }
                )
            }


            .buttonStyle(.bordered)
        }
    }
   

    func handleScan(_ scannedCode: String) {
        guard let action = qrAction else { return }

        switch action {
        case .activate:
            isSuccess = packagesVM.activatePackage(
                at: index,
                scannedCode: scannedCode
            )
            successText = isSuccess
            ? "Paketet är aktiverat"
            : "Fel QR‑kod"

        case .useMeal:
            isSuccess = packagesVM.useMeal(
                at: index,
                scannedCode: scannedCode
            )
            successText = isSuccess
            ? "En måltid har använts"
            : "Fel QR‑kod"
        }

        showQRScanner = false
        showSuccessView = true
        qrAction = nil
    }



}
