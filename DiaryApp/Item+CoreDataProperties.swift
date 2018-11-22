//
//  Item+CoreDataProperties.swift
//  DiaryApp
//
//  Created by Ehsan on 22/11/2018.
//  Copyright © 2018 Ali C. All rights reserved.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var text: String?

}
