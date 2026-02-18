//
//  ContentView.swift
//  Mealora-IOS
//
//  Created by Mahamed Adan on 2026-01-10.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var packagesVM = MyPackagesViewModel()
    private let offersVM = OffersViewModel()

    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white

        // Vald tab
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(foodoraPink)
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor(foodoraPink)
        ]

        //  Omarkerad tab
        appearance.stackedLayoutAppearance.normal.iconColor = .gray
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.gray
        ]

        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }

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
