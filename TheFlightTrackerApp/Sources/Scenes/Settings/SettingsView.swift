//
//  SettingsView.swift
//  TheFlightTrackerApp
//
//  Created by Ilhan Sari on 8.11.2021.
//

import UIKit

final class SettingsView: UIView {
    
    // MARK: - Properties
    lazy var segmentedControl: UISegmentedControl = {
        let segmentItems = ["kilometers", "miles"]
        let segmentedControl = UISegmentedControl(items: segmentItems)
        segmentedControl.layer.cornerRadius = 8
        return segmentedControl
    }()
    
    private lazy var sectionLabel: UILabel = .create(text: "Unit",
                                                     textColor: .white,
                                                     textAlignment: .center)
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [sectionLabel, segmentedControl])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10.0
        return stackView
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
private extension SettingsView {
    
    func arrangeViews() {
        backgroundColor = .lightGray
        
        addSubview(stackView)
        stackView.anchor(top: safeAreaLayoutGuide.topAnchor,
                         leading: leadingAnchor,
                         trailing: trailingAnchor, padding: UIEdgeInsets(top: 16.0,
                                                                         left: 16.0,
                                                                         bottom: 16.0,
                                                                         right: 16.0))
    }
}

