//
//  WeatherApi.swift
//  Weather
//
//  Created by Hoang Thi on 11/06/2022.
//

import Foundation
import Combine

protocol WeatherApi {
    func searchWeatherWithParam(_ param: [String: String]) -> AnyPublisher<Response<[DomainCity]>, RepositoryError>
    func getUrlForIconId(_ iconId: String) -> URL?
}
