//
//  UITableView+.swift
//  Weather
//
//  Created by Hoang Thi on 12/06/2022.
//

import UIKit

extension UITableView {
    func showMessage(_ message: String) {
        let label = UILabel(frame: bounds)
        label.text = message
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .gray
        backgroundView = label
    }
}
