//
//  Result.swift
//  TheFlightTrackerApp
//
//  Created by Ilhan Sari on 7.11.2021.
//

import Foundation

enum Result<Resource> {
  case success([Resource])
  case failure
}
