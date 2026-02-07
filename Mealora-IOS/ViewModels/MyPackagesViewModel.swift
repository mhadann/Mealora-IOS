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
}
