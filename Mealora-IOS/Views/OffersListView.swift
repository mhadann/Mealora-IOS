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

    @State private var searchText = ""
    @State private var selectedRestaurant: String? = nil

    var body: some View {
        NavigationStack {
            VStack(spacing: 12) {

                // Sökfält
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.secondary)

                    TextField("Sök erbjudande", text: $searchText)
                        .textInputAutocapitalization(.never)
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(14)
                .padding(.horizontal)

                // Restaurang-filter (chips)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        filterChip(
                            title: "Alla",
                            isSelected: selectedRestaurant == nil
                        ) {
                            selectedRestaurant = nil
                        }

                        ForEach(restaurants, id: \.self) { restaurant in
                            filterChip(
                                title: restaurant,
                                isSelected: selectedRestaurant == restaurant
                            ) {
                                selectedRestaurant = restaurant
                            }
                        }
                    }
                    .padding(.horizontal)
                }

                // Erbjudanden
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(filteredOffers) { offer in
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
                .scrollDismissesKeyboard(.immediately)
            }
            .onTapGesture {
                hideKeyboard()
            }
            .navigationTitle("Mealora")
        }
    }

    // MARK: - Filtrering

    private var restaurants: [String] {
        Array(Set(offers.map { $0.restaurantName })).sorted()
    }

    private var filteredOffers: [Offer] {
        offers.filter { offer in
            let matchesSearch =
                searchText.isEmpty ||
                offer.title.localizedCaseInsensitiveContains(searchText)

            let matchesRestaurant =
                selectedRestaurant == nil ||
                offer.restaurantName == selectedRestaurant

            return matchesSearch && matchesRestaurant
        }
    }

    // MARK: - UI Components

    private func filterChip(
        title: String,
        isSelected: Bool,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline.bold())
                .padding(.horizontal, 14)
                .padding(.vertical, 8)
                .background(isSelected ? foodoraPink : Color(.systemGray6))
                .foregroundColor(isSelected ? .white : .primary)
                .cornerRadius(20)
        }
    }

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

            // 🔹 Paket-titel
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

// MARK: - Keyboard helper

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}
