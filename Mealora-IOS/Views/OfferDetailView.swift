//
//  OfferDetailView.swift
//  Mealora-IOS
//
//  Created by Mahamed Adan on 2026-01-29.
//

import SwiftUI

// View för detaljer om erbjudandet

struct OfferDetailView: View {
    let offer: Offer
    @ObservedObject var packagesVM: MyPackagesViewModel
    
    @State private var goToMyPackages = false

    var body: some View {
        VStack(spacing: 16) {
            Text(offer.restaurantName)
                .font(.largeTitle)
                .bold()

            Text(offer.title)
                .font(.title2)

            Text("\(offer.meals) måltider")
            Text("\(offer.durationDays) dagar giltighet")
            Text("Pris: \(offer.price) kr")
            
            

            Button {
                packagesVM.buy(offer: offer)
                goToMyPackages = true
            } label: {
                Text("Köp")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .navigationDestination(isPresented: $goToMyPackages) {
                MyPackagesView()
                    .environmentObject(packagesVM)
            }


            Spacer()
        }
        .padding()
        .navigationTitle("Detaljer")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    ContentView()
}
