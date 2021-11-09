//
//  FlightModel.swift
//  TheFlightTrackerApp
//
//  Created by Ilhan Sari on 8.11.2021.
//

import Foundation

struct FlightModel: Codable, Equatable {

    var airlineId: String
    var flightNumber: Int
    var departureAirportId: String
    var arrivalAirportId: String
    
}
