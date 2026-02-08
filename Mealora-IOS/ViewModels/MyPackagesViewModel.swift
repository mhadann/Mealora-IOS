//
//  MyPackagesViewModel.swift
//  Mealora-IOS
//
//  Created by Mahamed Adan on 2026-01-29.
//

import Foundation
internal import Combine

// peket funktionen


final class MyPackagesViewModel: ObservableObject {
    @Published var packages: [Package] = []

    init() {
        packages = StorageManager.shared.load()
    }

    // vad som händer vid köp
    func buy(offer: Offer) {
        let newPackage = Package(
            id: UUID(),
            offer: offer,
            isActivated: false,
            activationDate: nil,
            mealsLeft: offer.meals
        )
        packages.append(newPackage)
        StorageManager.shared.save(packages)
    }
    
    
    // funktion för att aktivera paket
    
    func activatePackage(at index: Int, scannedCode: String) {
        guard packages.indices.contains(index) else { return }

        let expectedQR = packages[index].offer.qrCodeValue

        if scannedCode == expectedQR {
            packages[index].isActivated = true
            packages[index].activationDate = Date()
            StorageManager.shared.save(packages)
        }
    }
    
    func useMeal(at index: Int, scannedCode: String) {
        guard packages.indices.contains(index) else { return }

        let package = packages[index]

        guard package.isActivated else { return }
        guard package.mealsLeft > 0 else { return }

        let expectedQR = package.offer.qrCodeValue
        guard scannedCode == expectedQR else { return }

        packages[index].mealsLeft -= 1
        StorageManager.shared.save(packages)
    }

    


}
