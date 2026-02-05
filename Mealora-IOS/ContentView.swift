//
//  ContentView.swift
//  Mealora-IOS
//
//  Created by Mahamed Adan on 2026-01-29.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var packagesVM = MyPackagesViewModel()
    private let offersVM = OffersViewModel()

    var body: some View {
        TabView {
            OffersListView(
                offers: offersVM.offers,
                packagesVM: packagesVM
            )
            .tabItem {
                Label("Hem", systemImage: "house")
            }

            MyPackagesView()
                .environmentObject(packagesVM)
                .tabItem {
                    Label("Mina paket", systemImage: "ticket")
                }
        }
    }
}


#Preview {
    ContentView()
}
