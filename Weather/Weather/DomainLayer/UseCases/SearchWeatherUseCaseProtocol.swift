//
//  SearchWeatherUseCaseProtocol.swift
//  Weather
//
//  Created by Hoang Thi on 12/06/2022.
//

import Foundation
import Combine

protocol SearchWeatherUseCaseProtocol {
    func execute(cityName: String, numberDays: Int, units: String) -> AnyPublisher<Response<[DomainCity]>, RepositoryError>
}
