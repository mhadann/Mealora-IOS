//
//  Package.swift
//  Mealora-IOS
//
//  Created by Mahamed Adan on 2026-01-29.
//

import Foundation

// Hur datan ser ut för ett paket

struct Package: Identifiable, Codable {
    let id: UUID
    let offer: Offer
    var isActivated: Bool
    var activationDate: Date?
    var mealsLeft: Int
    
    var daysLeft: Int? {
        guard let activationDate else { return nil }

        let calendar = Calendar.current
        let endDate = calendar.date(byAdding: .day, value: 30, to: activationDate)!

        let days = calendar.dateComponents([.day], from: Date(), to: endDate).day
        return max(days ?? 0, 0)
    }
    
}


