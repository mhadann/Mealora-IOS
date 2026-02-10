//
//  OffersViewModel.swift
//  Mealora-IOS
//
//  Created by Mahamed Adan on 2026-01-22.
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
            restaurantName: "Lavolia Pizzeria",
            title: "kyckling pizza",
            meals: 10,
            price: 700,
            durationDays: 30,
            qrCode: "Lavolia-Pizzeria-qr",
            discountText: "Du sparar 30%",
            subtitle: "Smaka på det bästa hos Lavolia Pizzeria i Malmö!",
            imageName:"Lavolia_Pizzeria_cover",
            Logimage:  "Lavolia_Pizzeria_logo"
        ),
        
        Offer(
            id: UUID(),
            restaurantName: "Möllans Pizzeria",
            title: "pizza lunch",
            meals: 10,
            price: 750,
            durationDays: 30,
            qrCode: "Möllans-Pizzeria-qr",
            discountText: "Du sparar 30%",
            subtitle: "prova på Möllans Pizzeria",
            imageName:"Möllans_Pizzeria_cover",
            Logimage:  "Möllans_Pizzeria_logo"
        ),
        
        Offer(
            id: UUID(),
            restaurantName: "Sauvage",
            title: "Lunch special",
            meals: 10,
            price: 700,
            durationDays: 30,
            qrCode: "Sauvage-qr",
            discountText: "Du sparar 30%",
            subtitle: "prova på Sauvage",
            imageName:"Sauvage_cover",
            Logimage:  "Sauvage_logo"
        ),
        Offer(
            id: UUID(),
            restaurantName: "Bella Italia",
            title: "Bella pizza",
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
            restaurantName: "Restaurang Quê",
            title: "Lunch special",
            meals: 10,
            price: 850,
            durationDays: 30,
            qrCode: "Restaurang-Quê-qr",
            discountText: "Du sparar 30%",
            subtitle: "Vegetariska alternativ, Veganska alternativ, Glutenfria alternativ",
            imageName:"Restaurang_Quê_cover",
            Logimage:  "Restaurang_Quê_logo"
        ),
    ]
    
}


