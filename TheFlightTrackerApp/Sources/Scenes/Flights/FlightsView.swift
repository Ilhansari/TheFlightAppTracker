//
//  FlightsView.swift
//  TheFlightTrackerApp
//
//  Created by Ilhan Sari on 8.11.2021.
//

import UIKit

final class FlightsView: UIView {
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FlightCell.self, forCellReuseIdentifier: FlightCell.viewIdentifier)
        return tableView
    }()
    
    init() {
        super.init(frame: .zero)
        
        arrangeViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension FlightsView {
    
    func arrangeViews() {
        addSubview(tableView)
        tableView.fillSuperview()
    }
}
