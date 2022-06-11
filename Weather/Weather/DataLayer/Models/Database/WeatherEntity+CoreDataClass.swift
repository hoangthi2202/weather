//
//  WeatherEntity+CoreDataClass.swift
//  Weather
//
//  Created by Hoang Thi on 11/06/2022.
//
//

import Foundation
import CoreData


public class WeatherEntity: NSManagedObject {
    func updateWithDomainWeather(_ domainWeather: DomainWeather) {
        date = domainWeather.date
        averageTemp = domainWeather.averageTemp
        pressure = domainWeather.pressure
        humidity = domainWeather.humidity
        desc = domainWeather.desc
        iconId = domainWeather.iconId
    }
}
