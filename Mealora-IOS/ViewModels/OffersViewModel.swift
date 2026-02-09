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
            qrCode: "bella-italia-qr",
            discountText: "Du sparar 30%",
            subtitle: "Den här restaurangen är bra",
            imageName:"bella_italia_cover",
            Logimage:  "bella_italia_logo"
            
        ),
        Offer(
            id: UUID(),
            restaurantName: "Test restaurang",
            title: "Lunch special",
            meals: 10,
            price: 750,
            durationDays: 30,
            qrCode: "Test-restaurang-qr",
            discountText: "Du sparar 30%",
            subtitle: "Den här restaurangen är bra",
            imageName:"bella_italia_cover",
            Logimage:  "bella_italia_logo"
        )
    ]
    
}


