//
//  SearchWeatherVC.swift
//  Weather
//
//  Created by Hoang Thi on 11/06/2022.
//

import UIKit

protocol SearchWeatherViewProtocol: AnyObject {
    
}

class SearchWeatherVC: UIViewController {

    var presenter: SearchWeatherPresenterProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        let interactor = SearchWeatherInteractor()
        let wireFrame = SearchWeatherWireFrame()
        wireFrame.setupWithPresentedVC(self)
        presenter = SearchWeatherPresenter(
            interactor: interactor,
            wireFrame: wireFrame,
            view: self
        )
        presenter?.viewDidLoad()
    }
}

extension SearchWeatherVC: SearchWeatherViewProtocol {
    
}
