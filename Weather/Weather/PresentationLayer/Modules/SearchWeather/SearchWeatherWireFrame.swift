//
//  SearchWeatherWireFrame.swift
//  Weather
//
//  Created by Hoang Thi on 11/06/2022.
//

import Foundation
import UIKit

protocol SearchWeatherWireFrameProtocol {
    
}

class SearchWeatherWireFrame {
    func setupWithRootNavVC(_ navVC: UINavigationController) {
        let vc = SearchWeatherVC(nibName: "SearchWeatherVC", bundle: nil)
        let apiConfig = WeatherApiConfiguration()
        let remoteApi = RemoteDailyApi(apiConfig: apiConfig)
        let localStorage = WeatherCoreData()
        let repository = WeatherRepository(remoteApi: remoteApi, localStorage: localStorage)
        let useCase = SearchDailyWeatherUseCase(repository: repository)
        let interactor = SearchWeatherInteractor(searchUseCase: useCase)
        let wireFrame = SearchWeatherWireFrame()
        let presenter = SearchWeatherPresenter(
            interactor: interactor,
            wireFrame: wireFrame,
            view: vc
        )
        vc.presenter = presenter
        navVC.viewControllers = [vc]
    }
}

extension SearchWeatherWireFrame: SearchWeatherWireFrameProtocol {
    
}
