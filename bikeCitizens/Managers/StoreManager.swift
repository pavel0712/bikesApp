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
    
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return appDelegate.persistentContainer.viewContext
    }
    
    func fetchPlaces() -> [Place] {
        let fetchRequest: NSFetchRequest<Place> = Place.fetchRequest()
        do {
            return try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return []
    }
    
    func addRemoveMark(mark: MarkModel) {
        if let place = fetchPlace(byID: mark.markID) {
            self.deletePlace(place: place)
        } else {
            self.addPlace(fromMark: mark)
        }
    }
    
    func isPlaceExist(placeID: String) -> Bool {
        
        guard let _ = fetchPlace(byID: placeID) else { return false }
        
        return true
    }
    
    func fetchPlace(byID: String) -> Place? {
        let fetchRequest: NSFetchRequest<Place> = Place.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "placeID = %@", byID
        )
        
        do {
            return try context.fetch(fetchRequest).first
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return nil
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
        
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    
    func deletePlace(place: Place) {
        context.delete(place)
        
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    
    func parseLocalFile(forName: String) -> SearchResponse? {
        guard let data = readLocalFile(forName: forName) else {
            print("cant find file with name: ", forName)
            return nil
        }
        
        guard let response = parse(jsonData: data) else {
            return nil
        }
        
        return response
    }
    
    private func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name,
                                                 ofType: "json"),
                let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
    
    func parse(jsonData: Data) -> SearchResponse? {
        do {
            let decodedData = try JSONDecoder().decode(SearchResponse.self,
                                                       from: jsonData)
            
            print("decodedData.data.count: ", decodedData.data.count)
            print("===================================")
            return decodedData
        } catch {
            print("decode error")
        }
        
        return nil
    }
}
