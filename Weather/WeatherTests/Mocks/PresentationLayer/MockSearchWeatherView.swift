//
//  MockSearchWeatherView.swift
//  WeatherTests
//
//  Created by Hoang Thi on 13/06/2022.
//

import Foundation
@testable import Weather

class MockSearchWeatherView: SearchWeatherViewProtocol {
    var updateUIBlock: (() -> Void)?
    var hasShowErrorBlock: (() -> Void)?
    func updateUIWithData(_ data: DomainCity?) {
        updateUIBlock?()
    }
    
    func showErrorMessage(_ message: String) {
        hasShowErrorBlock?()
    }
}
