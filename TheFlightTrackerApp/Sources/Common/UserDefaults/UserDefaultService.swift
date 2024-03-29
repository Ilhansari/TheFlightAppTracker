//
//  UserDefaultService.swift
//  TheFlightTrackerApp
//
//  Created by Ilhan Sari on 8.11.2021.
//

import Foundation

final class UserDefaultsService {
    
    static let shared = UserDefaultsService()

    struct Key {
        static let isKm = "isKm"
    }

    let isInKmDefaultValue = "false"

    // MARK: - Initialization
    init() {
        UserDefaults
            .standard
            .register(defaults: [Key.isKm: isInKmDefaultValue])
    }
}

// MARK: - Containers
extension UserDefaultsService {

    var isKm: Bool {
        get {
            UserDefaults
                .standard
                .bool(forKey: Key.isKm)
        }
        set {
            UserDefaults
                .standard
                .setValue(newValue, forKey: Key.isKm)
        }
    }
}
