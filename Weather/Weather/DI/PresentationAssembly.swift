//
//  PresentationAssembly.swift
//  Weather
//
//  Created by Hoang Thi on 12/06/2022.
//

import Swinject

class PresentationAssemply: Assembly {
    func assemble(container: Container) {
        container.register(SearchWeatherInteractorProtocol.self) { r in
            let searchUseCase = r.resolve(SearchWeatherUseCaseProtocol.self)!
            let getIconURLUseCase = r.resolve(GetIconURLUseCaseProtocol.self)!
            let interactor = SearchWeatherInteractor(
                searchUseCase: searchUseCase,
                getIconURLUseCase: getIconURLUseCase
            )
            return interactor
        }
        container.register(SearchWeatherPresenterProtocol.self) { (r, wireFrame: SearchWeatherWireFrameProtocol, view: SearchWeatherViewProtocol) in
            let presenter = SearchWeatherPresenter(
                interactor: r.resolve(SearchWeatherInteractorProtocol.self)!,
                wireFrame: wireFrame,
                view: view
            )
            return presenter
        }
        container.register(SearchWeatherVC.self) { (r, wireFrame: SearchWeatherWireFrameProtocol) in
            let vc = SearchWeatherVC(nibName: "SearchWeatherVC", bundle: nil)
            let presenter = r.resolve(SearchWeatherPresenterProtocol.self, arguments: wireFrame, vc as SearchWeatherViewProtocol)!
            vc.presenter = presenter
            return vc
        }
    }
}
