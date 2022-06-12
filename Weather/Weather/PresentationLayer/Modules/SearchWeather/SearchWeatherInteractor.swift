//
//  SearchWeatherInteractor.swift
//  Weather
//
//  Created by Hoang Thi on 11/06/2022.
//

import Foundation
import Combine

protocol SearchWeatherInteractorProtocol {
    func searchWithCityName(_ cityName: String) -> AnyPublisher<Response<[DomainCity]>, RepositoryError>
}

class SearchWeatherInteractor {
    private let searchUseCase: SearchWeatherUseCaseProtocol
    init(searchUseCase: SearchWeatherUseCaseProtocol) {
        self.searchUseCase = searchUseCase
    }
}

extension SearchWeatherInteractor: SearchWeatherInteractorProtocol {
    func searchWithCityName(_ cityName: String) -> AnyPublisher<Response<[DomainCity]>, RepositoryError> {
        searchUseCase.execute(cityName: cityName, numberDays: 10, units: "metric")
    }
}
