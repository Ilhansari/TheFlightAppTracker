//
//  UILabel+Extension.swift
//  TheFlightTrackerApp
//
//  Created by Ilhan Sari on 8.11.2021.
//

import UIKit

// MARK: - Create UILabel
extension UILabel {
    static func create(text: String = "",
                       numberOfLines: Int = 0,
                       font: UIFont = .systemFont(ofSize: 16.0, weight: .semibold),
                       textColor: UIColor = .appColor,
                       textAlignment: NSTextAlignment = .left) -> UILabel {
        
        let label = UILabel()
        label.numberOfLines = numberOfLines
        label.font = font
        label.textColor = textColor
        label.textAlignment = textAlignment
        label.text = text
        return label
    }
}
