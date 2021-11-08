//
//  UserDefaultProtocol.swift
//  TheFlightTrackerApp
//
//  Created by Ilhan Sari on 8.11.2021.
//

import Foundation

//  MARK: UserDefaultsProtocol
/// Rewrite value from User Defaults for
/// testing purposes.
///
protocol UserDefaultsProtocol {

  /// Track user settings for distance unit.
  ///
  var isInKm: Bool { get set }
}
