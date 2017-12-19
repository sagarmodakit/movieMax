//
//  RecentSearches+CoreDataProperties.swift
//  
//
//  Created by sagarmodak on 19/12/17.
//
//

import Foundation
import CoreData


extension RecentSearches {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecentSearches> {
        return NSFetchRequest<RecentSearches>(entityName: "RecentSearches")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var date: NSDate?

}
