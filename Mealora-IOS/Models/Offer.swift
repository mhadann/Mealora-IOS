//
//  Offer.swift
//  Mealora-IOS
//
//  Created by Mahamed Adan on 2026-01-29.
//
import Foundation

// Hur datan ser ut för ett erbjudande

struct Offer: Identifiable, Codable {
    let id: UUID
    let restaurantName: String
    let title: String
    let meals: Int
    let price: Int
    let durationDays: Int
    let qrCodeValue: String
}
