//
//  FlightCell.swift
//  TheFlightTrackerApp
//
//  Created by Ilhan Sari on 8.11.2021.
//

import UIKit

final class FlightCell: UITableViewCell {
    
    // MARK: - Properties
    private lazy var nameLabel: UILabel = .create(textColor: .appColor)
    
    private lazy var distanceLabel: UILabel = .create(textColor: .systemIndigo)
    
    static let identifier = "FlightCell"
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            nameLabel,
            distanceLabel
        ])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10.0
        stackView.layoutMargins = UIEdgeInsets(top: 12.0, left: 12.0, bottom: 12.0, right: 12.0)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        arrangeViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        distanceLabel.text = nil
    }
}

// MARK: - Arrange Views
private extension FlightCell {
    
    func arrangeViews() {
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
}

// MARK: - Populate UI
extension FlightCell {
    
    func populateUI(model: AirportsModel, distance: String) {
        nameLabel.text = model.name
        distanceLabel.text = distance
    }
}
