//
//  AirportsView.swift
//  TheFlightTrackerApp
//
//  Created by Ilhan Sari on 7.11.2021.
//

import UIKit

final class AirportsView: UIView {

    private lazy var mapView = MapView()

    init() {
        super.init(frame: .zero)

        arrangeViews()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: Arrange Views
private extension AirportsView {

    func arrangeViews() {
        addSubview(mapView)
        mapView.fillSuperview()
    }
}

