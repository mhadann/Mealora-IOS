//
//  PackageCardView.swift
//  Mealora-IOS
//
//  Created by Mahamed Adan on 2026-01-29.
//

//
//  PackageCardView.swift
//  Mealora-IOS
//
//  Created by Mahamed Adan on 2026-01-29.
//

//
//  PackageCardView.swift
//  Mealora-IOS
//
//  Created by Mahamed Adan on 2026-01-29.
//

import SwiftUI
import AudioToolbox

struct PackageCardView: View {
    let package: Package
    let index: Int

    @ObservedObject var packagesVM: MyPackagesViewModel

    @State private var showQRScanner = false
    @State private var qrAction: QRAction?
    @State private var showSuccessView = false
    @State private var successText = ""
    @State private var isSuccess = false

    enum QRAction {
        case activate
        case useMeal
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {

            // MARK: - Header
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(package.offer.title)
                        .font(.headline)

                    Text(package.offer.restaurantName)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }

                Spacer()

                // 🔁 Samma plats & stil – olika text beroende på status
                Text(
                    package.isActivated
                    ? "Ta med kvitot"
                    : "Betala vid första hämtning"
                )
                .font(.caption.bold())
                .foregroundColor(foodoraPink)
                .padding(.horizontal, 10)
                .padding(.vertical, 6)
                .background(Color(.systemGray6))
                .clipShape(Capsule())
            }

            // MARK: - Description
            Text("Giltig i 30 dagar från och med när du hämtar din första måltid")
                .font(.footnote)
                .foregroundColor(.secondary)

            // MARK: - Status
            if package.isActivated, let daysLeft = package.daysLeft {
                Text("\(daysLeft) dagar kvar")
                    .font(.subheadline.bold())
                    .foregroundColor(daysLeft <= 3 ? .red : .secondary)
            }

            if package.isActivated {
                Text("\(package.mealsLeft) måltider kvar")
                    .font(.subheadline.bold())
                    .foregroundColor(.secondary)
            }

            // MARK: - Actions
            if !package.isActivated {
                Button {
                    qrAction = .activate
                    showQRScanner = true
                } label: {
                    Text("Aktivera")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(foodoraPink)
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                }
                .buttonStyle(.plain)
            }

            if package.isActivated && package.mealsLeft > 0 {
                Button {
                    qrAction = .useMeal
                    showQRScanner = true
                } label: {
                    Text("Använd måltid")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 14)
                        .background(foodoraPink.opacity(0.15))
                        .foregroundColor(foodoraPink)
                        .clipShape(Capsule())
                }
                .buttonStyle(.plain)
            }
        }
        .padding(20)
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal)
        .padding(.vertical, 8)

        // MARK: - Sheets
        .sheet(isPresented: $showQRScanner) {
            QRScannerView { scannedCode in
                handleScan(scannedCode)
            }
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
    }

    // MARK: - QR Handling
    private func handleScan(_ scannedCode: String) {
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
