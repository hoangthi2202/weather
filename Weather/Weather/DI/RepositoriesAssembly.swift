//
//  RepositoriesAssembly.swift
//  Weather
//
//  Created by Hoang Thi on 12/06/2022.
//

import Swinject

class RepositoriesAssembly: Assembly {
    func assemble(container: Container) {
        container.register(ApiConfiguration.self) { _ in
            WeatherApiConfiguration()
        }
        container.register(WeatherApi.self) { r in
            let apiConfig = r.resolve(ApiConfiguration.self)!
            let remoteApi = RemoteDailyApi(apiConfig: apiConfig)
            return remoteApi
        }
        container.register(WeatherStorage.self) { r in
            WeatherCoreData()
        }
        container.register(WeatherRepositoryProtocol.self) { r in
            let remoteApi = r.resolve(WeatherApi.self)!
            let localStorage = r.resolve(WeatherStorage.self)!
            let repository = WeatherRepository(
                remoteApi: remoteApi,
                localStorage: localStorage
            )
            return repository
        }
        
    }
}
