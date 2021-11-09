//
//  UserDefaultService.swift
//  TheFlightTrackerApp
//
//  Created by Ilhan Sari on 8.11.2021.
//

final class UserDefaultsService {
    
    static let shared = UserDefaultsService()

    var userDefaultsContainer: UserDefaultsProtocol

    // MARK: - Initialization
    init(userDefaultsContainer: UserDefaultsProtocol = UserDefaultsContainer()) {
        self.userDefaultsContainer = userDefaultsContainer
    }
}

// MARK: - Containers
extension UserDefaultsService {

    var isKm: Bool {
        get {
            userDefaultsContainer.isKm
        }
        set {
            userDefaultsContainer.isKm = newValue
        }
    }
}
