//
//  WeatherCoreData.swift
//  Weather
//
//  Created by Hoang Thi on 11/06/2022.
//

import Foundation
import Combine
import CoreData

class WeatherCoreData: CoreDataManager {
}

extension WeatherCoreData: WeatherStorage {
    func saveWeather(_ domainCites: [DomainCity]) -> AnyPublisher<Bool, RepositoryError> {
        Future<Bool, RepositoryError> { [weak self] promise in
            self?.performOnBGContext { [weak self] context in
                
                for domainCity in domainCites {
                    if CityEntity.existCityId(domainCity.id, inContext: context) {
                        continue
                    }
                    
                    let city = CityEntity(context: context)
                    city.id = Int64(domainCity.id)
                    city.name = domainCity.name
                    for domainWeather in domainCity.weathers {
                        let weather = WeatherEntity(context: context)
                        weather.updateWithDomainWeather(domainWeather)
                        city.addToWeathers(weather)
                    }
                }
                
                self?.saveBackgroundContext { [weak self] saved in
                    if saved {
                        self?.saveContext()
                    }
                    promise(.success(saved))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    func searchWeatherWithCityName(_ cityName: String) -> AnyPublisher<Response<[DomainCity]>, RepositoryError> {
        Future<Response<[DomainCity]>, RepositoryError> { [weak self] promise in
            self?.performOnMainContext { context in
                guard cityName.count > 0 else {
                    promise(.failure(.notFound))
                    return
                }
                
                guard
                    let cityEntities = CityEntity.searchCityByName(cityName, inContext: context),
                    cityEntities.count > 0
                else {
                    promise(.failure(.notFound))
                    return
                }
                
                var domainCities = [DomainCity]()
                for cityEntity in cityEntities {
                    let domainCity = DomainCity.createByCityEntity(cityEntity)
                    domainCities.append(domainCity)
                }
                promise(.success(.succeed(domainCities)))
            }
        }
        .eraseToAnyPublisher()
    }
}
