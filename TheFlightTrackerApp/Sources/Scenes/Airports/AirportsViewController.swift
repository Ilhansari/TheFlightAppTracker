//
//  AirportsViewController.swift
//  TheFlightTrackerApp
//
//  Created by Ilhan Sari on 7.11.2021.
//

import UIKit

final class AirportsViewController: UIViewController {
    
    // MARK: - Properties
    private lazy var viewSource: AirportsView = {
        let view = AirportsView()
        return view
    }()
    
    private var viewModel = AirportsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = viewSource
        
        viewSource.startMapping()
        viewModel.getAirportsData()
        viewModel.delegate = self
        viewSource.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewSource.checkDistanceUnitSettings()
    }
}

// MARK: - AirportsViewModelDelegate
extension AirportsViewController: AirportsViewModelDelegate {
    
    func handleShowAlert(message: String) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.showAlert(title: "Error!", message: message)
        }
    }
    
    func handleLoading(isLoading: Bool) {
        DispatchQueue.main.async {
            isLoading ? self.showSpinner(onView: self.view) : self.removeSpinner()
        }
    }
    
    func handleData(airportsModel: [AirportsModel]) {
        DispatchQueue.main.async {
            self.viewSource.getAirportsModel(model: airportsModel)
            self.viewSource.populateAnnotations()
            self.viewSource.foundAirportsFurthestApart()
        }
    }
}

// MARK: AirportsViewDelegate
extension AirportsViewController: AirportsViewDelegate {
    
    func didTapDisclosureButton(model: AirportDetailsModel) {
        let airportDetailsViewController = AirportDetailViewController(airportDetails: model)
        airportDetailsViewController.modalPresentationStyle = .pageSheet
        present(airportDetailsViewController, animated: true, completion: nil)
    }
}
