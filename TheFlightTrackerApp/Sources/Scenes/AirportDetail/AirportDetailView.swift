//
//  AirportDetailView.swift
//  TheFlightTrackerApp
//
//  Created by Ilhan Sari on 8.11.2021.
//

import UIKit

final class AirportDetailView: UIView {

    private enum Constants {
        static let distanceFormat = "%.2f %@"
        static let kmUnit = "km"
        static let milesUnit = "mi"
    }
    
    // MARK: - Properties
    private lazy var titleLabel: UILabel = .create(font: UIFont.systemFont(ofSize: 20.0,
                                                                           weight: .bold),
                                                   textColor: .systemIndigo,
                                                   textAlignment: .center)
    
    private lazy var idLabel: UILabel = .create()
    private lazy var latitudeLabel: UILabel = .create()
    private lazy var longitudeLabel: UILabel = .create()
    private lazy var nameLabel: UILabel = .create()
    private lazy var cityLabel: UILabel = .create()
    private lazy var countyIdLabel: UILabel = .create()
    private lazy var nearestAirportLabel: UILabel = .create()
    private lazy var distanceAirportLabel: UILabel = .create()
    
    var isInKm = UserDefaultsService.shared.isInKm
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            idLabel,
            latitudeLabel,
            longitudeLabel,
            nameLabel,
            cityLabel,
            countyIdLabel,
            nearestAirportLabel,
            distanceAirportLabel
        ])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20.0
        return stackView
    }()

    init() {
        super.init(frame: .zero)
        
        arrangeViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Arrange Views
private extension AirportDetailView {
    
    func arrangeViews() {
        backgroundColor = .black
        addSubview(stackView)
        stackView.anchor(top: safeAreaLayoutGuide.topAnchor,
                         leading: leadingAnchor,
                         trailing: trailingAnchor,
                         padding: UIEdgeInsets(top: 24.0, left: 12.0, bottom: 0.0, right: 12.0))
    }
}

// MARK: - Populate UI
extension AirportDetailView {
    
    func populateUI(model: AirportDetailsModel) {
        titleLabel.text = "Airport Details"
        idLabel.text = "ID: \(model.airport.id)"
        latitudeLabel.text = "LATITUDE: \(model.airport.latitude)"
        longitudeLabel.text = "LONGITUDE: \(model.airport.longitude)"
        nameLabel.text = "NAME: \(model.airport.name)"
        cityLabel.text = "CITY: \(model.airport.city)"
        countyIdLabel.text = "COUNTRY ID: \(model.airport.countryId)"
        nearestAirportLabel.text = "NEAREST AIRPORT: \(model.nearestAirport ?? "")"
        let unit = isInKm ? Constants.kmUnit : Constants.milesUnit
        let airportDistance = String(format: Constants.distanceFormat, model.airportsDistance, unit)
        distanceAirportLabel.text = "DISTANCE AIRPORT: \(airportDistance)"
    }
}
