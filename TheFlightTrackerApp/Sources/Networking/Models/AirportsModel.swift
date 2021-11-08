//
//  AirportsModel.swift
//  TheFlightTrackerApp
//
//  Created by Ilhan Sari on 7.11.2021.
//

import Foundation
import CoreLocation

struct AirportsModel: Codable, Equatable {
    let id: String
    let latitude: Double
    let longitude: Double
    let name: String
    let city: String
    let countryId: String

    /// Setup airport location.
    ///
    var location: CLLocation {
      return CLLocation(latitude: latitude,
                        longitude: longitude)
    }

    /// Calculate distance from two core location points in km
    /// or in miles.
    ///
    /// Used to calculate the distance between two airports.
    ///
    func distance(_ isInKm: Bool = true, to location: CLLocation) -> CLLocationDistance {
      guard isInKm else {
        return self.location.distance(from: location) * 0.000621371
      }
      return self.location.distance(from: location) / 1000
    }
}
