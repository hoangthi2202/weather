//
//  WeatherStorage.swift
//  Weather
//
//  Created by Hoang Thi on 11/06/2022.
//

import Foundation
import Combine

protocol WeatherStorage {
    func searchWeatherWithCityName(_ cityName: String) -> AnyPublisher<Response<[DomainCity]>, RepositoryError>
    func saveWeather(_ domainCites: [DomainCity]) -> AnyPublisher<Bool, RepositoryError>
}
