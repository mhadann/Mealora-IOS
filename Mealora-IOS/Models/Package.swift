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
}
