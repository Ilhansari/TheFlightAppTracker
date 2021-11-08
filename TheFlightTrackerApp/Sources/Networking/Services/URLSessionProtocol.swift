//
//  HTTPClient.swift
//  TheFlightTrackerApp
//
//  Created by Ilhan Sari on 7.11.2021.
//

import Foundation

protocol URLSessionProtocol {
  func dataTask(with url: URL,
                completionHandler: @escaping (Data?,
                                              URLResponse?,
                                              Error?) -> Void) -> URLSessionDataTask
}
