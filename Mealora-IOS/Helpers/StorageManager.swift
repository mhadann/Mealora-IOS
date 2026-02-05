//
//  StorageManager.swift
//  Mealora-IOS
//
//  Created by Mahamed Adan on 2026-01-29.
//

import Foundation

// lokal lagring
// Sparar paket lokalt på telefonen

final class StorageManager {
    static let shared = StorageManager()
    private let key = "my_packages"

    private init() {}

    func save(_ packages: [Package]) {
        if let data = try? JSONEncoder().encode(packages) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    func load() -> [Package] {
        guard
            let data = UserDefaults.standard.data(forKey: key),
            let packages = try? JSONDecoder().decode([Package].self, from: data)
        else {
            return []
        }
        return packages
    }
}
