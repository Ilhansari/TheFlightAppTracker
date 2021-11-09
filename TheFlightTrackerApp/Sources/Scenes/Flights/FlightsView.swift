//
//  FlightsView.swift
//  TheFlightTrackerApp
//
//  Created by Ilhan Sari on 8.11.2021.
//

import UIKit

final class FlightsView: UIView {

    // MARK: - Properties
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FlightCell.self, forCellReuseIdentifier: FlightCell.identifier)
        return tableView
    }()

    // MARK: - Initialization
    init() {
        super.init(frame: .zero)
        
        arrangeViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Arrange Views
private extension FlightsView {
    
    func arrangeViews() {
        addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
}
