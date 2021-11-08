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

    private var OK_200: Int {
        return 200
    }
    
    init(_ resourceURL: NetworkEndpoint, session: URLSessionProtocol = URLSession.shared) {
        self.resourceURL = resourceURL
        self.session = session
    }

}

extension NetworkService {
  /// Get request with an array as a response.
  ///
  func getData(_ completion: @escaping (Result<[Resource], Error>) -> Void) {

    let dataTask = session.dataTask(with: resourceURL.url) { data, response, error in
      guard let httpResponse = response as? HTTPURLResponse else {
        return completion(.failure(NSError()))
      }
      guard httpResponse.statusCode == OK_200,
            let jsonData = data else {
        return completion(.failure(NSError()))
      }
      do {
        let resources = try JSONDecoder().decode([Resource].self,
                                                 from: jsonData)
        completion(.success(resources))
      }
      catch {
        completion(.failure(NSError()))
      }
    }
    dataTask.resume()
  }
}

