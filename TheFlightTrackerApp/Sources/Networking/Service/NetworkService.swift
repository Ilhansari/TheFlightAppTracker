//
//  NetworkService.swift
//  TheFlightTrackerApp
//
//  Created by Ilhan Sari on 7.11.2021.
//

import Foundation

struct NetworkService<Resource> where Resource: Codable {

  var resourceURL: NetworkEndpoint

  var session: URLSessionProtocol

  init(_ resourceURL: NetworkEndpoint, session: URLSessionProtocol = URLSession.shared) {
    self.resourceURL = resourceURL
    self.session = session
  }
}

extension NetworkService {
  /// Get request with an array as a response.
  ///
  func getData(_ completion: @escaping (Result<Resource>) -> Void) {

    
    let dataTask = session.dataTask(with: resourceURL.url) { data, response, _ in
      guard let httpResponse = response as? HTTPURLResponse else {
        return completion(.failure)
      }
      guard httpResponse.statusCode == 200,
            let jsonData = data else {
        return completion(.failure)
      }
      do {
        let resources = try JSONDecoder().decode([Resource].self,
                                                 from: jsonData)
        completion(.success(resources))
      }
      catch {
        completion(.failure)
      }
    }
    dataTask.resume()
  }
}

