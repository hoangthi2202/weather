//
//  WeatherRepositoryProtocol.swift
//  Weather
//
//  Created by Hoang Thi on 11/06/2022.
//

import Foundation
import Combine

protocol WeatherRepositoryProtocol {
    func searchWithCityName(_ cityName: String, numberDays: Int, unit: String) -> AnyPublisher<Response<[DomainCity]>, RepositoryError>
    func getURLForIconId(_ iconId: String) -> URL?
}
