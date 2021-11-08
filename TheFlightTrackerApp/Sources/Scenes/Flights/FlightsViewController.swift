//
//  FlightsViewController.swift
//  TheFlightTrackerApp
//
//  Created by Ilhan Sari on 8.11.2021.
//

import UIKit

final class FlightsViewController: UIViewController {
    
    private lazy var viewModel = FlightsViewModel()
    private lazy var viewSource = FlightsView()
    
    private var airportsCount: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = viewSource
        
        viewModel.delegate = self
        viewSource.tableView.delegate = self
        viewSource.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.checkDistanceUnitSettings()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension FlightsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.countAirports()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FlightCell.viewIdentifier,
                                                 for: indexPath) as! FlightCell
        let airport = viewModel.airportsConnectedModel[indexPath.row]
        let distance = viewModel.distanceFromSchiphol(to: airport)
        cell.populateUI(model: airport, distance: distance)
        return cell
    }
}

// MARK: - FlightsViewModelDelegate
extension FlightsViewController: FlightsViewModelDelegate {
    func didLoadData() {
        DispatchQueue.main.async {
            self.viewSource.tableView.reloadData()
        }
    }
}
