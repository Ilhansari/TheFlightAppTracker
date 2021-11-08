//
//  UserDefaultService.swift
//  TheFlightTrackerApp
//
//  Created by Ilhan Sari on 8.11.2021.
//

import Foundation

final class UserDefaultsService {
  static let shared = UserDefaultsService()


  var userDefaultsContainer: UserDefaultsProtocol
  init(userDefaultsContainer: UserDefaultsProtocol = UserDefaultsContainer()) {
    self.userDefaultsContainer = userDefaultsContainer
  }
}

// MARK: - Containers
extension UserDefaultsService {
  /// Track user settings for distance unit.
  ///
  var isInKm: Bool {
    get {
      userDefaultsContainer.isInKm
    }
    set {
      userDefaultsContainer.isInKm = newValue
    }
  }
}
