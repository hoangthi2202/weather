//
//  SearchWeatherPresenter.swift
//  Weather
//
//  Created by Hoang Thi on 11/06/2022.
//

import Foundation

protocol SearchWeatherPresenterProtocol: BasePresenterProtocol {
    
}

class SearchWeatherPresenter {
    private let wireFrame: SearchWeatherWireFrameProtocol
    private let interactor: SearchWeatherInteractorProtocol
    private weak var view: SearchWeatherViewProtocol?
    init(interactor: SearchWeatherInteractorProtocol, wireFrame: SearchWeatherWireFrameProtocol, view: SearchWeatherViewProtocol?) {
        self.wireFrame = wireFrame
        self.interactor = interactor
        self.view = view
    }
}

extension SearchWeatherPresenter: BasePresenterProtocol {
    func viewDidLoad() {
        
    }
}

extension SearchWeatherPresenter: SearchWeatherPresenterProtocol {
    
}
