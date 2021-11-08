//
//  FlightCell.swift
//  TheFlightTrackerApp
//
//  Created by Ilhan Sari on 8.11.2021.
//

import UIKit

final class FlightCell: UITableViewCell {
    
    private lazy var nameLabel: UILabel = .create(textColor: .black)
    private lazy var distanceLabel: UILabel = .create(textColor: .systemIndigo)
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            nameLabel,
            distanceLabel
        ])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10.0
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        arrangeViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Arrange Views
private extension FlightCell {
    
    func arrangeViews() {
        addSubview(stackView)
        stackView.fillSuperview(with: UIEdgeInsets(top: 12.0,
                                                   left: 12.0,
                                                   bottom: 12.0,
                                                   right: 12.0))
    }
}

extension FlightCell {
    
    func populateUI(model: AirportsModel, distance: String) {
        nameLabel.text = model.name
        distanceLabel.text = distance
    }
}
