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
    func getURLForIconId(_ iconId: String) -> URL?
}

class SearchWeatherInteractor {
    private let searchUseCase: SearchWeatherUseCaseProtocol
    private let getIconURLUseCase: GetIconURLUseCaseProtocol
    init(searchUseCase: SearchWeatherUseCaseProtocol, getIconURLUseCase: GetIconURLUseCaseProtocol) {
        self.searchUseCase = searchUseCase
        self.getIconURLUseCase = getIconURLUseCase
    }
}

extension SearchWeatherInteractor: SearchWeatherInteractorProtocol {
    func searchWithCityName(_ cityName: String) -> AnyPublisher<Response<[DomainCity]>, RepositoryError> {
        searchUseCase.execute(
            cityName: cityName,
            numberDays: 10,
            units: "metric"
        )
    }
    
    func getURLForIconId(_ iconId: String) -> URL? {
        getIconURLUseCase.execute(iconId: iconId)
    }
}
