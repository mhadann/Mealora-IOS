//
//  MyPackagesView.swift
//  Mealora-IOS
//
//  Created by Mahamed Adan on 2026-01-29.
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
                }
            }
            .navigationTitle("Mina paket")
        }
    }
}

#Preview {
    MyPackagesView()
        .environmentObject(MyPackagesViewModel())
}
