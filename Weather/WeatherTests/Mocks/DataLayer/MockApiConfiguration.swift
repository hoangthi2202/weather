//
//  MockApiConfiguration.swift
//  WeatherTests
//
//  Created by Hoang Thi on 13/06/2022.
//

import Foundation
@testable import Weather

struct MockApiConfiguration: ApiConfiguration {
    var baseURLString: String {
        ""
    }
    
    var appAPI: String? {
        ""
    }
    
    var baseIconURLString: String {
        ""
    }
    
    
}
