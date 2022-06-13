//
//  UseCaseTests.swift
//  WeatherTests
//
//  Created by Hoang Thi on 13/06/2022.
//

import XCTest
import Combine
@testable import Weather

class UseCaseTests: XCTestCase {
    private var searchUseCase: SearchDailyWeatherUseCase?
    private var getIconURLUseCase: GetIconURLUseCase?
    private var repository: MockWeatherRepository!
    private var cancellable = [AnyCancellable]()
    override func setUpWithError() throws {
        repository = MockWeatherRepository()
    }

    override func tearDownWithError() throws {
        searchUseCase = nil
        getIconURLUseCase = nil
    }

    func testSearchDailyWeatherUseCase() throws {
        repository.expectedSearchResult = [DomainCity(id: 0, name: "", weathers: [])]
        searchUseCase = SearchDailyWeatherUseCase(repository: repository)
        
        let expectationReceive = expectation(description: "Incorrect result: count != 1")
        searchUseCase?.execute(cityName: "", numberDays: 1, units: "")
            .sink(receiveCompletion: { result in
                
            }, receiveValue: { response in
                switch response {
                case .succeed(let domainCities):
                    if domainCities.count == 1 {
                        expectationReceive.fulfill()
                    }
                case .failed(message: _): break
                }
                
            })
            .store(in: &cancellable)
        wait(for: [expectationReceive], timeout: 1)
    }

    func testGetIconURLUseCase() throws {
        repository.expectedIconURL = URL(string: "http://icon.com")
        getIconURLUseCase = GetIconURLUseCase(repository: repository)
        
        let url = getIconURLUseCase?.execute(iconId: "")
        XCTAssertEqual(url, repository.expectedIconURL)
    }
}
