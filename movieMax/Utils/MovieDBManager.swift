//
//  MovieDBManager.swift
//  movieMax
//
//  Created by sagarmodak on 19/12/17.
//  Copyright © 2017 webwerks. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class MovieDBManager : NSObject {
    
    func isRecordExist(withEntiryName entityName: String, with predicate: NSPredicate) -> Any? {
        var _record: Any? = nil
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate

        let managedObjectContext = appDelegate.persistentContainer.viewContext

        let _fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        do {
            let _entityDesc = NSEntityDescription.entity(forEntityName: entityName, in: managedObjectContext)
            _fetchRequest.entity = _entityDesc!
            _fetchRequest.predicate = predicate
            _fetchRequest.fetchLimit = 1
            
            let _fetchedOjects = try managedObjectContext.fetch(_fetchRequest)
            if _fetchedOjects.count > 0 {
                _record = _fetchedOjects[0]
            }
            
        } catch let error as NSError {
            print("Error While Fetching Data From DB: \(error.userInfo)")
        }
        
        return _record
    }

    func saveRecentSearches(searchName : String) {
        

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        

        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<RecentSearches>(entityName: "RecentSearches")
        
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        
        var newId = 0
        
        do {
            let results:[RecentSearches] = try managedObjectContext.fetch(fetchRequest as! NSFetchRequest<NSFetchRequestResult> ) as! [RecentSearches]

            if(results.count == 1)
            {
                newId = Int(Int32(results[0].id + 1))

            }else {
                
                newId = 1
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
        
        let _searchInformation: RecentSearches? = NSEntityDescription.insertNewObject(forEntityName: "RecentSearches", into: managedObjectContext) as? RecentSearches
        
        _searchInformation?.id = Int64(newId)
       
        _searchInformation?.name = searchName
       
        _searchInformation?.date = Date()

        appDelegate.saveContext()
    }
    
    func getAllSearchesFromDB(entityName : String) -> [String] {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        var _record = [String]()
        
        let _fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        _fetchRequest.returnsObjectsAsFaults = false
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        _fetchRequest.sortDescriptors = [sortDescriptor]
        let _entityDesc = NSEntityDescription.entity(forEntityName: entityName, in: managedObjectContext)
        _fetchRequest.entity = _entityDesc!
        _fetchRequest.fetchLimit = 10
        
        do {
            let _fetchedOjects = try managedObjectContext.fetch(_fetchRequest)
            
            for i in 0..<_fetchedOjects.count {
                
                if let value = _fetchedOjects[i] as? RecentSearches {
                    _record.append(value.name!)
                }

            }
            
        } catch let error as NSError {
            print("Error While Fetching Data From DB: \(error.userInfo)")
        }
        
        return _record
    }
    
}
