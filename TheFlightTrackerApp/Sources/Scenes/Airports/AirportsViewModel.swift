//
//  AirportsViewModel.swift
//  TheFlightTrackerApp
//
//  Created by Ilhan Sari on 7.11.2021.
//

import UIKit

protocol AirportsViewDelegate: AnyObject {
    func handleData(airportsModel: [AirportsModel])
}

final class AirportsViewModel {

    // MARK: - Properties
    private var airportsModel = [AirportsModel]()

    weak var delegate: AirportsViewDelegate?

    func getAirportsData() {
        let airportsService = NetworkService<AirportsModel>(.airports)
        airportsService.getData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.airportsModel = response
                self.delegate?.handleData(airportsModel: response)
            case .failure:
                break
            }
        }
    }
}
