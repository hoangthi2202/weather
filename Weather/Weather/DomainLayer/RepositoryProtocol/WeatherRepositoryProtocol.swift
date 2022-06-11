//
//  WeatherRepositoryProtocol.swift
//  Weather
//
//  Created by Hoang Thi on 11/06/2022.
//

import Foundation
import Combine

protocol WeatherRepositoryProtocol {
    func searchWithParam(_ param: [String: String]) -> AnyPublisher<Response<[DomainCity]>, RepositoryError>
}
