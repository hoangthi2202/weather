//
//  DomainCity.swift
//  Weather
//
//  Created by Hoang Thi on 11/06/2022.
//

import Foundation

struct DomainCity {
    let id: Int
    let name: String
    let weathers: [DomainWeather]
}

extension DomainCity {
    static func createByCityEntity(_ entity: CityEntity) -> DomainCity {
        var weathers = [DomainWeather]()
        if let weatherEntities = entity.weathers?.allObjects as? [WeatherEntity] {
            for weatherEntity in weatherEntities {
                let weather = DomainWeather.createByWeatherEntity(weatherEntity)
                weathers.append(weather)
            }
        }
        
        return DomainCity(
            id: Int(entity.id),
            name: entity.name ?? "",
            weathers: weathers
        )
    }
    
    static func createByDailyCity(_ dailyCity: DailyCity) -> DomainCity {
        var weathers = [DomainWeather]()
        for list in dailyCity.list {
            let weather = DomainWeather(
                date: Date(timeIntervalSince1970: TimeInterval(list.dt)),
                averageTemp: list.temp.day,
                pressure: Double(list.pressure),
                humidity: Double(list.humidity),
                desc: list.weather.first?.weatherDescription ?? "",
                iconId: list.weather.first?.icon ?? ""
            )
            weathers.append(weather)
        }
        
        return DomainCity(
            id: dailyCity.city.id,
            name: dailyCity.city.name,
            weathers: weathers
        )
    }
}
