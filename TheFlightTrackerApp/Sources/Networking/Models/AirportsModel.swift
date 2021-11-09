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
    
    var location: CLLocation {
        return CLLocation(latitude: latitude,
                          longitude: longitude)
    }
    
    func distance(_ isKm: Bool = true, to location: CLLocation) -> CLLocationDistance {
        guard isKm else {
            return self.location.distance(from: location) * 0.000621371
        }
        return self.location.distance(from: location) / 1000
    }
}
