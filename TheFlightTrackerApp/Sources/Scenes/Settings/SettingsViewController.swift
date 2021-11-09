//
//  SettingsViewController.swift
//  TheFlightTrackerApp
//
//  Created by Ilhan Sari on 8.11.2021.
//

import UIKit

final class SettingsViewController: UIViewController {
    
    private lazy var viewSource = SettingsView()
    
    private enum Constants {
        static let kmValue = 0
        static let milesValue = 1
    }
    
    private var isKm = UserDefaultsService.shared.isKm
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = viewSource
        setupSegmentedControl()
    }
    
    private func setupSegmentedControl() {
        viewSource.segmentedControl.selectedSegmentIndex = isKm ? Constants.kmValue : Constants.milesValue
        viewSource.segmentedControl.addTarget(self,
                                              action: #selector(changeUnit),
                                              for: .valueChanged)
    }
    
    @objc func changeUnit() {
        switch viewSource.segmentedControl.selectedSegmentIndex {
        case Constants.kmValue:
            UserDefaultsService.shared.isKm = true
        case Constants.milesValue:
            UserDefaultsService.shared.isKm = false
        default: ()
        }
    }
}
