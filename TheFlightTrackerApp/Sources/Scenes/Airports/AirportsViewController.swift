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
    
    func handleData(airportsModel: [AirportsModel]) {
        self.viewSource.airportModels = airportsModel
        self.viewSource.populateAnnotations()
        self.viewSource.foundAirportsFurthestApart()
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
