//
//  StoreManager.swift
//  bikeCitizens
//
//  Created by Paul on 26.02.22.
//

import Foundation
import CoreText
import CoreData
import UIKit

class StoreManager {
    
    static let shared = StoreManager()
    
    private var context: NSManagedObjectContext {
        
        return persistentContainer.viewContext
    }
    
    func fetchPlaces() -> [Place] {
        let fetchRequest: NSFetchRequest<Place> = Place.fetchRequest()

        return (try? context.fetch(fetchRequest)) ?? []
    }
    
    func addRemoveMark(mark: MarkModel) {
        if let place = fetchPlace(byID: mark.markID) {
            self.deletePlace(place: place)
        } else {
            self.addPlace(fromMark: mark)
        }
    }
    
    func isPlaceExist(placeID: String) -> Bool {
                
        return fetchPlace(byID: placeID) != nil
    }
    
    func addPlace(fromMark: MarkModel) {
        guard let placeEntity = NSEntityDescription.entity(forEntityName: "Place", in: context) else { return }
        let placeObj = Place(entity: placeEntity, insertInto: context)
        
        placeObj.placeID = fromMark.markID
        placeObj.name = fromMark.name
        placeObj.summary = fromMark.summary
        placeObj.iconURL = fromMark.iconURL
        placeObj.lat = fromMark.lat
        placeObj.lon = fromMark.lon
        
        saveContext()
    }
    
    func deletePlace(place: Place) {
        context.delete(place)
        saveContext()
    }
    
    private func fetchPlace(byID: String) -> Place? {
        let fetchRequest: NSFetchRequest<Place> = Place.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "placeID = %@", byID
        )

        return try? context.fetch(fetchRequest).first
    }
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "bikeCitizens")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
        
        NotificationCenter.default
            .post(name:.coreDataDidChange,
                  object: nil,
                  userInfo: nil)
    }
    
}
