//
//  OffersViewModel.swift
//  Mealora-IOS
//
//  Created by Mahamed Adan on 2026-01-29.
//

import Foundation

final class OffersViewModel {
    
    //en array av erbjudande lista
    
    let offers: [Offer] = [
        Offer(
            id: UUID(),
            restaurantName: "Bella Italia",
            title: "Lunch special",
            meals: 10,
            price: 750,
            durationDays: 30,
            qrCode: "bella-italia-qr"
        ),
        Offer(
            id: UUID(),
            restaurantName: "Test restaurang",
            title: "Lunch special",
            meals: 10,
            price: 750,
            durationDays: 30,
            qrCode: "Test-restaurang-qr"
        )
    ]
    
}


