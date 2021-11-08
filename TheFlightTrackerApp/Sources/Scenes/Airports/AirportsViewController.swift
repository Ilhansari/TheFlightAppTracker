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
    }
}

// MARK: - AirportsViewDelegate
extension AirportsViewController: AirportsViewDelegate {
    func handleData(airportsModel: [AirportsModel]) {
        self.viewSource.populateAnnotations(airportsModel)
    }
}
