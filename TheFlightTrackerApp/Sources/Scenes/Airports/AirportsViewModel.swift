//
//  AirportsViewModel.swift
//  TheFlightTrackerApp
//
//  Created by Ilhan Sari on 7.11.2021.
//

import UIKit

protocol AirportsViewModelDelegate: AnyObject {
    func handleData(airportsModel: [AirportsModel])
}

final class AirportsViewModel {

    // MARK: - Properties
    weak var delegate: AirportsViewModelDelegate?

    func getAirportsData() {
        let airportsService = NetworkService<AirportsModel>(.airports)
        airportsService.getData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.delegate?.handleData(airportsModel: response)
                }
            case .failure:
                break
            }
        }
    }
}
