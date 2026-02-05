//
//  OffersListView.swift
//  Mealora-IOS
//
//  Created by Mahamed Adan on 2026-01-29.
//

import SwiftUI

// View för lista med erbjudande

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
                    VStack(alignment: .leading) {
                        Text(offer.restaurantName)
                            .font(.headline)
                        Text("\(offer.price) kr")
                            .font(.subheadline)
                    }
                }
            }
            .navigationTitle("Erbjudanden")
        }
    }
}
