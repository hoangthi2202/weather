//
//  UseCaseAssembly.swift
//  Weather
//
//  Created by Hoang Thi on 12/06/2022.
//

import Swinject

class UseCaseAssembly: Assembly {
    func assemble(container: Container) {
        container.register(SearchWeatherUseCaseProtocol.self) { r in
            let repository = r.resolve(WeatherRepositoryProtocol.self)!
            let useCase = SearchDailyWeatherUseCase(repository: repository)
            return useCase
        }
        
        container.register(GetIconURLUseCaseProtocol.self) { r in
            let repository = r.resolve(WeatherRepositoryProtocol.self)!
            let getIconURLUseCase = GetIconURLUseCase(repository: repository)
            return getIconURLUseCase
        }
    }
}
