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

    private var resourceURL: NetworkEndpoint

    private var successStatusCode: Int {
        return 200
    }
    
    init(_ resourceURL: NetworkEndpoint) {
        self.resourceURL = resourceURL
    }
}

extension NetworkService {

    func getData(_ completion: @escaping (Result<[Resource], Error>) -> Void) {

        let dataTask = URLSession.shared.dataTask(with: resourceURL.url) { data, response, _ in
            guard let response = response as? HTTPURLResponse else {
                return completion(.failure(.invalidData))
            }
            return completion(map(data, from: response))
        }
        dataTask.resume()
    }

    private func map(_ data: Data?, from response: HTTPURLResponse) -> Result<[Resource], Error> {
        guard response.statusCode == successStatusCode,
              let data = data,
              let resources = try? JSONDecoder().decode([Resource].self, from: data) else {
            return .failure(.invalidData)
        }
        return .success(resources)
    }
}
