//
//  DomainWeather.swift
//  Weather
//
//  Created by Hoang Thi on 11/06/2022.
//

import Foundation

struct DomainWeather {
    var date: Date
    var averageTemp: Double
    var pressure: Double
    var humidity: Double
    var desc: String
    var iconId: String
}

extension DomainWeather {
    static func createByWeatherEntity(_ entity: WeatherEntity) -> DomainWeather {
        return DomainWeather(
            date: entity.date ?? Date(),
            averageTemp: entity.averageTemp,
            pressure: entity.pressure,
            humidity: entity.humidity,
            desc: entity.desc ?? "",
            iconId: entity.iconId ?? ""
        )
    }
}
