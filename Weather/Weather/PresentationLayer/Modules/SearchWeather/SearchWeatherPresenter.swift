//
//  SearchWeatherPresenter.swift
//  Weather
//
//  Created by Hoang Thi on 11/06/2022.
//

import Foundation
import Combine

protocol SearchWeatherPresenterProtocol: BasePresenterProtocol {
    
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
        interactor.searchWithCityName("hanoi")
            .sink { result in
                switch result {
                case .failure(let error):
                    WLog.debug("SearchWeatherPresenter failure: \(error)")
                case .finished:
                    WLog.debug("SearchWeatherPresenter finished")
                }
            } receiveValue: { response in
                WLog.debug("response: \(response)")
            }
            .store(in: &cancellables)
    }
}

extension SearchWeatherPresenter: SearchWeatherPresenterProtocol {
    
}
