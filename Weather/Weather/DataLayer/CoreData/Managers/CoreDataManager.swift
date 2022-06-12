//
//  CoreDataManager.swift
//  Weather
//
//  Created by Hoang Thi on 11/06/2022.
//

import UIKit
import CoreData

class CoreDataManager {
    
    private lazy var backgroundContext: NSManagedObjectContext = {
        let context = self.persistentContainer.newBackgroundContext()
        context.automaticallyMergesChangesFromParent = true
        return context
    }()
    
    // MARK: - Core Data stack
    private lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        WLog.debug("defaultDirectoryURL: ", NSPersistentContainer.defaultDirectoryURL())
        let container = NSPersistentContainer(name: "Weather")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    
    func saveBackgroundContext(completion: @escaping (Bool) -> Void) {
        guard backgroundContext.hasChanges else {
            completion(false)
            return
        }
        backgroundContext.perform { [weak self] in
            do {
                try self?.backgroundContext.save()
                completion(true)
            } catch {
                WLog.debug("Save error \(error)")
                completion(false)
            }
        }
    }
    
    //MARK: Init with dependency
    init() {
        self.persistentContainer.viewContext.automaticallyMergesChangesFromParent = true
        self.initDefaultValue()
    }
    
    private func initDefaultValue() {
        let center = NotificationCenter.default
        let notification = UIApplication.willResignActiveNotification
        
        center.addObserver(forName: notification, object: nil, queue: nil) { [weak self] _ in
            guard let self = self else { return }
            self.saveContext()
        }
    }
    
}

extension CoreDataManager {
    func saveContext () {
        let context = persistentContainer.viewContext
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    func performOnMainContext(contextBlock: @escaping (NSManagedObjectContext) -> Void) {
        persistentContainer.viewContext.perform { [weak self] in
            guard let self = self else { return }
            contextBlock(self.persistentContainer.viewContext)
        }
    }
    
    func performOnBGContext(contextBlock: @escaping (NSManagedObjectContext) -> Void) {
        backgroundContext.perform { [weak self] in
            guard let self = self else { return }
            contextBlock(self.backgroundContext)
        }
    }
}
