//
//  NetworkEndPoint.swift
//  TheFlightTrackerApp
//
//  Created by Ilhan Sari on 7.11.2021.
//

import Foundation

enum NetworkEndpoint {

  /// Base api url.
  ///
  static let baseURL = URL(string: "https://flightassets.datasavannah.com/test/")!

  // API endpoints
  case airports
  case flights

  /// Fetching SchipholAirport endpoint.
  ///
  var url: URL {
    switch self {
    case .airports:
      return NetworkEndpoint.baseURL.appendingPathComponent("airports.json")
    case .flights:
      return NetworkEndpoint.baseURL.appendingPathComponent("flights.json")
    }
  }
}
