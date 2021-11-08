//
//  SettingsViewController.swift
//  TheFlightTrackerApp
//
//  Created by Ilhan Sari on 8.11.2021.
//

import UIKit

final class SettingsViewController: UIViewController {

    private lazy var viewSource = SettingsView()

    private var isInKm = UserDefaultsService.shared.isInKm

    override func viewDidLoad() {
        super.viewDidLoad()

        view = viewSource
        setupSegmentedControl()
    }

    private func setupSegmentedControl() {
        viewSource.segmentedControl.selectedSegmentIndex = isInKm ? 0 : 1
        viewSource.segmentedControl.addTarget(self,
                                                  action: #selector(changeUnit),
                                                  for: .valueChanged)
    }

    @objc func changeUnit() {
        switch viewSource.segmentedControl.selectedSegmentIndex {
      case 0:
        UserDefaultsService.shared.isInKm = true
      case 1:
        UserDefaultsService.shared.isInKm = false
      default: ()
      }
    }
}
