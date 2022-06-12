//
//  SearchWeatherPresenter.swift
//  Weather
//
//  Created by Hoang Thi on 11/06/2022.
//

import Foundation
import Combine

protocol SearchWeatherPresenterProtocol: BasePresenterProtocol {
    func searchWithCityName(_ cityName: String)
    func getCellModelOf(_ object: DomainWeather) -> WeatherCellModel
}

class SearchWeatherPresenter {
    private let wireFrame: SearchWeatherWireFrameProtocol
    private let interactor: SearchWeatherInteractorProtocol
    private weak var view: SearchWeatherViewProtocol?
    private var cancellables = [AnyCancellable]()
    init(interactor: SearchWeatherInteractorProtocol, wireFrame: SearchWeatherWireFrameProtocol, view: SearchWeatherViewProtocol?) {
        self.wireFrame = wireFrame
        self.interactor = interactor
        self.view = view
    }
}

extension SearchWeatherPresenter: BasePresenterProtocol {
    func viewDidLoad() {
        searchWithCityName("hanoi")
    }
}

extension SearchWeatherPresenter: SearchWeatherPresenterProtocol {
    func searchWithCityName(_ cityName: String) {
        interactor.searchWithCityName(cityName)
            .receive(on: DispatchQueue.main)
            .sink { result in
                switch result {
                case .failure(let error):
                    WLog.debug("SearchWeatherPresenter failure: \(error)")
                    self.view?.showErrorMessage(error.message())
                case .finished:
                    WLog.debug("SearchWeatherPresenter finished")
                }
            } receiveValue: { response in
                switch response {
                case .succeed(let cities):
                    self.view?.updateUIWithData(cities.first!)
                case .failed(message: let message):
                    self.view?.showErrorMessage(message)
                }
            }
            .store(in: &cancellables)
    }
    
    func getCellModelOf(_ object: DomainWeather) -> WeatherCellModel {
        WeatherCellModel(
            dateStr: "Date: \(object.date.formatString())",
            averageTempStr: "Average Temperature: \(Int(object.averageTemp))°C ",
            pressureStr: "Pressure: \(Int(object.pressure))",
            humidityStr: "Humidity: \(Int(object.humidity))%",
            desc: "Description: \(object.desc)",
            iconURL: interactor.getURLForIconId(object.iconId)
        )
    }
}
