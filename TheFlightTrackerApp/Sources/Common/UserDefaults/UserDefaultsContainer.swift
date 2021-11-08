//
//  UserDefaultsContainer.swift
//  TheFlightTrackerApp
//
//  Created by Ilhan Sari on 8.11.2021.
//

import Foundation


final class UserDefaultsContainer {

    struct Key {
        static let isInKm = "isInKm"
    }

    let IsInKmDefaultValue = "true"

    // MARK: - Initialization
    init() {
        UserDefaults
            .standard
            .register(defaults: [Key.isInKm: IsInKmDefaultValue])
    }
}

// MARK: - Containers
extension UserDefaultsContainer: UserDefaultsProtocol {
    
    var isInKm: Bool {
        get {
            UserDefaults
                .standard
                .bool(forKey: Key.isInKm)
        }
        set {
            UserDefaults
                .standard
                .setValue(newValue, forKey: Key.isInKm)
        }
    }
}
