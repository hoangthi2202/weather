//
//  SearchDailyWeatherUseCase.swift
//  Weather
//
//  Created by Hoang Thi on 11/06/2022.
//

import Foundation
import Combine

class SearchDailyWeatherUseCase {
    private let repository: WeatherRepositoryProtocol
    init(repository: WeatherRepositoryProtocol) {
        self.repository = repository
    }
}

extension SearchDailyWeatherUseCase: SearchWeatherUseCaseProtocol {
    func execute(cityName: String, numberDays: Int, units: String) -> AnyPublisher<Response<[DomainCity]>, RepositoryError> {
        repository.searchWithParam([
            "q"     : cityName,
            "cnt"   : "\(numberDays)",
            "units" : units
        ])
    }
}
