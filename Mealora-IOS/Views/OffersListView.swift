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
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(offers) { offer in
                        NavigationLink {
                            OfferDetailView(
                                offer: offer,
                                packagesVM: packagesVM
                            )
                        } label: {
                            offerCard(offer)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
            .navigationTitle("Mealora")
        }
    }

    // 🔹 Kort för erbjudande
    private func offerCard(_ offer: Offer) -> some View {
        VStack(alignment: .leading, spacing: 12) {

            // 🔹 Bild med overlay (restaurang + logo)
            ZStack(alignment: .bottomLeading) {
                Image(offer.imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 180)
                    .clipped()
                    .cornerRadius(16)

                HStack(spacing: 10) {
                    Image(offer.Logimage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 36, height: 36)
                        .clipShape(RoundedRectangle(cornerRadius: 8))

                    Text(offer.restaurantName)
                        .font(.subheadline.bold())
                        .foregroundColor(.white)
                }
                .padding(10)
                .background(
                    LinearGradient(
                        colors: [.black.opacity(0.6), .clear],
                        startPoint: .bottom,
                        endPoint: .top
                    )
                )
            }

            // 🔹 Paket‑titel
            Text(offer.title)
                .font(.headline)

            // 🔹 Subtitle
            Text(offer.subtitle)
                .font(.subheadline)
                .foregroundColor(.secondary)

            // 🔹 Pris + rabatt
            HStack {
                Text("\(offer.price) kr")
                    .font(.headline)

                Spacer()

                Text(offer.discountText)
                    .font(.caption.bold())
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(foodoraPink.opacity(0.15))
                    .foregroundColor(foodoraPink)
                    .cornerRadius(12)
            }
        }
    }
}
