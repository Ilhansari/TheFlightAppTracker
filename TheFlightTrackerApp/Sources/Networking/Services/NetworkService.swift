//
//  NetworkService.swift
//  TheFlightTrackerApp
//
//  Created by Ilhan Sari on 7.11.2021.
//

import Foundation

struct NetworkService<Resource> where Resource: Codable {

    enum Error: Swift.Error {
        case connectivity
        case invalidData
    }

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

    func getData(_ completion: @escaping (Result<[Resource], Error>) -> Void) {

        let dataTask = session.dataTask(with: resourceURL.url) { data, response, error in
            guard let response = response as? HTTPURLResponse else {
                return completion(.failure(.invalidData))
            }
            return completion(map(data, from: response))
        }
        dataTask.resume()
    }

    private func map(_ data: Data?, from response: HTTPURLResponse) -> Result<[Resource], Error> {
        guard response.statusCode == OK_200,
              let data = data,
              let resources = try? JSONDecoder().decode([Resource].self, from: data) else {
            return .failure(.invalidData)
        }
        return .success(resources)
    }
}

