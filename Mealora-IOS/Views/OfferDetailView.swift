//
//  OfferDetailView.swift
//  Mealora-IOS
//
//  Created by Mahamed Adan on 2026-01-29.
//

import SwiftUI

struct OfferDetailView: View {
    let offer: Offer
    @ObservedObject var packagesVM: MyPackagesViewModel

    @State private var goToMyPackages = false

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {

                // Bild med overlay (restaurang + logo)
                ZStack(alignment: .bottomLeading) {
                    Image(offer.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 240)
                        .clipped()
                        .cornerRadius(16)

                    HStack(spacing: 12) {
                        Image(offer.Logimage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 44, height: 44)
                            .clipShape(RoundedRectangle(cornerRadius: 10))

                        Text(offer.restaurantName)
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(
                        LinearGradient(
                            colors: [.black.opacity(0.6), .clear],
                            startPoint: .bottom,
                            endPoint: .top
                        )
                    )
                }

                // Paket‑titel (huvudtitel)
                Text(offer.title)
                    .font(.title.bold())
                    .frame(maxWidth: .infinity, alignment: .leading)

                // Rabatt‑badge
                Text(offer.discountText)
                    .font(.subheadline.bold())
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(foodoraPink.opacity(0.15))
                    .foregroundColor(foodoraPink)
                    .cornerRadius(20)
                    .frame(maxWidth: .infinity, alignment: .leading)

                // Info‑kort
                VStack(spacing: 12) {
                    infoRow(title: "Måltider", value: "\(offer.meals) st")
                    infoRow(title: "Giltighet", value: "\(offer.durationDays) dagar")
                    infoRow(title: "Pris", value: "\(offer.price) kr")
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(16)

                // Köp‑knapp
                Button {
                    packagesVM.buy(offer: offer)
                    goToMyPackages = true
                } label: {
                    Text("Köp")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(foodoraPink)
                        .foregroundColor(.white)
                        .cornerRadius(14)
                }

                Spacer(minLength: 16)
            }
            .padding()
        }
        .navigationTitle("Detaljer")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(isPresented: $goToMyPackages) {
            MyPackagesView()
                .environmentObject(packagesVM)
        }
    }

    // Hjälp‑UI
    private func infoRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .bold()
        }
    }
}

#Preview {
    ContentView()
}
