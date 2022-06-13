//
//  MockSearchWeatherInteractor.swift
//  WeatherTests
//
//  Created by Hoang Thi on 13/06/2022.
//

import Foundation
import Combine
@testable import Weather

class MockSearchWeatherInteractor: SearchWeatherInteractorProtocol {
    var expectedSearchResult = [DomainCity]()
    var expectedLocalError = false
    var expectedResponseError = false
    var expectedIconURL: URL?
    func searchWithCityName(_ cityName: String) -> AnyPublisher<Response<[DomainCity]>, RepositoryError> {
        if expectedLocalError {
            return Fail<Response<[DomainCity]>, RepositoryError>(error: RepositoryError.notFound).eraseToAnyPublisher()
        }
        
        return Future<Response<[DomainCity]>, RepositoryError> { promise in
            if self.expectedResponseError {
                promise(.success(Response.failed(message: "")))
                return
            }
            promise(.success(Response.succeed(self.expectedSearchResult)))
        }.eraseToAnyPublisher()
    }
    
    func getURLForIconId(_ iconId: String) -> URL? {
        expectedIconURL
    }
}
