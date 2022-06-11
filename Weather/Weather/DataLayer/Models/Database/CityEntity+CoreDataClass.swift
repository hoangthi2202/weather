//
//  CityEntity+CoreDataClass.swift
//  Weather
//
//  Created by Hoang Thi on 11/06/2022.
//
//

import Foundation
import CoreData

public class CityEntity: NSManagedObject {
    static func existCityId(_ cityId: Int, inContext context: NSManagedObjectContext) -> Bool {
        do {
            let fetchRequest = CityEntity.fetchRequest()
            fetchRequest.fetchLimit = 1
            fetchRequest.predicate = NSPredicate(
                format: "id = %d", cityId
            )
            let objects = try context.fetch(fetchRequest)
            return objects.count > 0
        } catch {
            print("[Core Data] existCityId error: \(error)")
        }
        return false
    }
    
    static func searchCityByName(_ cityName: String, inContext context: NSManagedObjectContext) -> [CityEntity]? {
        let request: NSFetchRequest<CityEntity> = CityEntity.fetchRequest()
        request.predicate = NSPredicate(
            format: "name CONTAINS %@", cityName
        )
        let results = try? context.fetch(request)
        return results
    }
}
