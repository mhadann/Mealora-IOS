//
//  MyPackagesView.swift
//  Mealora-IOS
//
//  Created by Mahamed Adan on 2026-01-20.
//
import SwiftUI

struct MyPackagesView: View {
    @EnvironmentObject var packagesVM: MyPackagesViewModel

    var body: some View {
        NavigationStack {
            List {
                ForEach(
                    Array(packagesVM.packages.enumerated()),
                    id: \.element.id
                ) { index, package in
                    PackageCardView(
                        package: package,
                        index: index,
                        packagesVM: packagesVM
                    )
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.white)
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(Color.white)          
            .navigationTitle("Mina paket")
        }
        .background(Color.white)
    }
}

#Preview {
    MyPackagesView()
        .environmentObject(MyPackagesViewModel())
}
