//
//  CityEntity+CoreDataProperties.swift
//  Weather
//
//  Created by Hoang Thi on 11/06/2022.
//
//

import Foundation
import CoreData


extension CityEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CityEntity> {
        return NSFetchRequest<CityEntity>(entityName: "CityEntity")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var weathers: NSSet?

}

// MARK: Generated accessors for weathers
extension CityEntity {

    @objc(addWeathersObject:)
    @NSManaged public func addToWeathers(_ value: WeatherEntity)

    @objc(removeWeathersObject:)
    @NSManaged public func removeFromWeathers(_ value: WeatherEntity)

    @objc(addWeathers:)
    @NSManaged public func addToWeathers(_ values: NSSet)

    @objc(removeWeathers:)
    @NSManaged public func removeFromWeathers(_ values: NSSet)

}

extension CityEntity : Identifiable {

}
