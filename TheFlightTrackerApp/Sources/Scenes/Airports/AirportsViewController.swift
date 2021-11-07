//
//  AirportsViewController.swift
//  TheFlightTrackerApp
//
//  Created by Ilhan Sari on 7.11.2021.
//

import UIKit

final class AirportsViewController: UIViewController {

    private lazy var viewSource: AirportsView = {
        let view = AirportsView()
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = viewSource
    }
}
