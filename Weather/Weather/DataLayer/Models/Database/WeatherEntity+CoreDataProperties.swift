//
//  WeatherEntity+CoreDataProperties.swift
//  Weather
//
//  Created by Hoang Thi on 11/06/2022.
//
//

import Foundation
import CoreData


extension WeatherEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WeatherEntity> {
        return NSFetchRequest<WeatherEntity>(entityName: "WeatherEntity")
    }

    @NSManaged public var date: Date?
    @NSManaged public var averageTemp: Double
    @NSManaged public var pressure: Double
    @NSManaged public var humidity: Double
    @NSManaged public var desc: String?
    @NSManaged public var iconId: String?
    @NSManaged public var city: CityEntity?

}

extension WeatherEntity : Identifiable {

}
