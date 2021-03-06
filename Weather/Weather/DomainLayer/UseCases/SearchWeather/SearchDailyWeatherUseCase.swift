//
//  SearchDailyWeatherUseCase.swift
//  Weather
//
//  Created by Hoang Thi on 11/06/2022.
//

import Foundation
import Combine

protocol SearchWeatherUseCaseProtocol {
    func execute(cityName: String, numberDays: Int, units: String) -> AnyPublisher<Response<[DomainCity]>, RepositoryError>
}

class SearchDailyWeatherUseCase {
    private let repository: WeatherRepositoryProtocol
    init(repository: WeatherRepositoryProtocol) {
        self.repository = repository
    }
}

extension SearchDailyWeatherUseCase: SearchWeatherUseCaseProtocol {
    func execute(cityName: String, numberDays: Int, units: String) -> AnyPublisher<Response<[DomainCity]>, RepositoryError> {
        repository.searchWithCityName(
            cityName,
            numberDays: numberDays,
            unit: units
        )
    }
}
