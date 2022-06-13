//
//  MockWeatherRepository.swift
//  WeatherTests
//
//  Created by Hoang Thi on 13/06/2022.
//

import Foundation
import Combine
@testable import Weather

class MockWeatherRepository: WeatherRepositoryProtocol {
    var expectedSearchResult = [DomainCity]()
    var expectedIconURL: URL?
    func searchWithCityName(_ cityName: String, numberDays: Int, unit: String) -> AnyPublisher<Response<[DomainCity]>, RepositoryError> {
        Future<Response<[DomainCity]>, RepositoryError> { promise in
            promise(.success(Response.succeed(self.expectedSearchResult)))
        }.eraseToAnyPublisher()
    }
    
    func getURLForIconId(_ iconId: String) -> URL? {
        expectedIconURL
    }
}
