//
//  AirportsModel.swift
//  TheFlightTrackerApp
//
//  Created by Ilhan Sari on 7.11.2021.
//

import Foundation
import CoreLocation

struct AirportsModel: Codable {
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
}
