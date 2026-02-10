//
//  MyPackagesViewModel.swift
//  Mealora-IOS
//
//  Created by Mahamed Adan on 2026-01-19.
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
    
    func activatePackage(at index: Int, scannedCode: String) -> Bool {
        guard packages.indices.contains(index) else { return false }

        let expectedQR = packages[index].offer.qrCode
        guard scannedCode == expectedQR else { return false }

        packages[index].isActivated = true
        packages[index].activationDate = Date()
        StorageManager.shared.save(packages)
        return true
    }

    
    func useMeal(at index: Int, scannedCode: String) -> Bool {
        guard packages.indices.contains(index) else { return false }

        let package = packages[index]
        guard package.isActivated else { return false }
        guard package.mealsLeft > 0 else { return false }

        let expectedQR = package.offer.qrCode
        guard scannedCode == expectedQR else { return false }

        packages[index].mealsLeft -= 1
        StorageManager.shared.save(packages)
        return true
    }

    


    


}
