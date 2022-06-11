//
//  File.swift
//  Weather
//
//  Created by Hoang Thi on 11/06/2022.
//

import Foundation

protocol ApiConfiguration {
    var baseURLString: String { get }
    var appAPI: String? { get }
    var baseIconURLString: String { get }
}
