//
//  AirportsViewModel.swift
//  TheFlightTrackerApp
//
//  Created by Ilhan Sari on 7.11.2021.
//

protocol AirportsViewModelDelegate: AnyObject {
    func handleData(airportsModel: [AirportsModel])
    func handleLoading(isLoading: Bool)
    func handleShowAlert(message: String)
}

final class AirportsViewModel {
    
    // MARK: - Properties
    weak var delegate: AirportsViewModelDelegate?
    
    func getAirportsData() {
        let airportsService = NetworkService<AirportsModel>(.airports)
        self.delegate?.handleLoading(isLoading: true)
        airportsService.getData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.delegate?.handleData(airportsModel: response)
                self.delegate?.handleLoading(isLoading: false)
            case .failure(let error):
                self.delegate?.handleShowAlert(message: error.localizedDescription)
                self.delegate?.handleLoading(isLoading: false)
            }
        }
    }
}
