//
//  Date+.swift
//  Weather
//
//  Created by Hoang Thi on 11/06/2022.
//

import Foundation

extension Date {
    func formatString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, d MMM yyyy"
        let dateFromStr = dateFormatter.string(from: self)
        return dateFromStr
    }
}
