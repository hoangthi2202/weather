//
//  SearchWeatherPresenter.swift
//  WeatherTests
//
//  Created by Hoang Thi on 13/06/2022.
//

import XCTest
import Combine
@testable import Weather

class SearchWeatherPresenterTests: XCTestCase {

    private var presenter: SearchWeatherPresenter!
    private var interactor: MockSearchWeatherInteractor!
    private var view: MockSearchWeatherView!
    override func setUpWithError() throws {
        interactor = MockSearchWeatherInteractor()
        view = MockSearchWeatherView()
        presenter = SearchWeatherPresenter(
            interactor: interactor,
            wireFrame: SearchWeatherWireFrame(),
            view: view
        )
    }

    override func tearDownWithError() throws {
        presenter = nil
        interactor = nil
        view = nil
    }

    func testSearchSuccess() throws {
        let expectationReceive = expectation(description: "Note Update UI")
        view.updateUIBlock = {
            expectationReceive.fulfill()
        }
        presenter.searchWithCityName("aa")
        wait(for: [expectationReceive], timeout: 1)
    }
    
    func testSearchFailByError() throws {
        let expectationReceive = expectation(description: "Note Update UI")
        view.updateUIBlock = {
            expectationReceive.fulfill()
        }
        interactor.expectedLocalError = true
        presenter.searchWithCityName("aa")
        wait(for: [expectationReceive], timeout: 1)
    }
    
    func testSearchFailByResponse() throws {
        let expectationReceive = expectation(description: "Note Update UI")
        view.updateUIBlock = {
            expectationReceive.fulfill()
        }
        interactor.expectedResponseError = true
        presenter.searchWithCityName("aa")
        wait(for: [expectationReceive], timeout: 1)
    }
    
    func testGetCellModel() throws {
        let domainObj = DomainWeather(date: Date(), averageTemp: 1, pressure: 1, humidity: 1, desc: "aaa", iconId: "")
        let model = presenter.getCellModelOf(domainObj)
        XCTAssertTrue(model.desc.contains(domainObj.desc))
    }
}
