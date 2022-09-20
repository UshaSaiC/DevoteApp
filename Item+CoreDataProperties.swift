//
//  Item+CoreDataProperties.swift
//  DevoteApp
//
//  Created by Usha Sai Chintha on 20/09/22.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var task: String?
    @NSManaged public var timestamp: Date?

}

extension Item : Identifiable {

}
