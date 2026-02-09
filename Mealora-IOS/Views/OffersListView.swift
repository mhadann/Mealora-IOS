//
//  OffersListView.swift
//  Mealora-IOS
//
//  Created by Mahamed Adan on 2026-01-29.
//

import SwiftUI

let foodoraPink = Color(red: 0.93, green: 0.00, blue: 0.39)

struct OffersListView: View {
    let offers: [Offer]
    @ObservedObject var packagesVM: MyPackagesViewModel

    var body: some View {
        NavigationStack {
            List(offers) { offer in
                NavigationLink {
                    OfferDetailView(
                        offer: offer,
                        packagesVM: packagesVM
                    )
                } label: {

                    VStack(alignment: .leading, spacing: 0) {

                        // 🖼️ HERO-BILD
                        ZStack(alignment: .topLeading) {
                            Image(offer.imageName)
                                .resizable()
                                .scaledToFill()
                                .frame(height: 160)
                                .clipped()

                            // 🏷️ Rabatt-badge
                            Text(offer.discountText)
                                .font(.caption.bold())
                                .foregroundColor(.white)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(foodoraPink)
                                .clipShape(Capsule())
                                .padding(12)

                            // 🍽️ LOGO
                            VStack {
                                Spacer()
                                HStack {
                                    Image(offer.Logimage)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 44, height: 44)
                                        .background(Color.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 12))
                                        .shadow(radius: 4)
                                        .padding(12)

                                    Spacer()
                                }
                            }

                        }
                        

                        // 📝 TEXT-INNEHÅLL
                        VStack(alignment: .leading, spacing: 6) {
                            Text(offer.restaurantName)
                                .font(.headline)

                            Text(offer.subtitle)
                                .font(.subheadline)
                                .foregroundColor(.secondary)

                            Text("\(offer.price) kr")
                                .font(.headline)
                                .foregroundColor(foodoraPink)
                        }
                        .padding()
                    }
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.08), radius: 8, y: 4)
                }
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                
            }
            .listStyle(.plain)
            .navigationTitle("Mealora")
        }
        
    }
}
