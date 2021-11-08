//
//  AirportDetailViewController.swift
//  TheFlightTrackerApp
//
//  Created by Ilhan Sari on 8.11.2021.
//

import UIKit

final class AirportDetailViewController: UIViewController {
    
    private lazy var viewSource: AirportDetailView = {
        let view = AirportDetailView()
        return view
    }()
    
    private var airportDetails: AirportDetailsModel
    
    // MARK: - Initialization
    init(airportDetails: AirportDetailsModel) {
        self.airportDetails = airportDetails
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = viewSource
        viewSource.populateUI(model: airportDetails)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewSource.isInKm = UserDefaultsService.shared.isInKm
    }
}
