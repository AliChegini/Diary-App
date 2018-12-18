//
//  Item+CoreDataProperties.swift
//  DiaryApp
//
//  Created by Ehsan on 22/11/2018.
//  Copyright © 2018 Ali C. All rights reserved.
//
//

import UIKit
import CoreData


extension Item {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        let request =  NSFetchRequest<Item>(entityName: "Item")
        request.sortDescriptors = [NSSortDescriptor(key: "text", ascending: true)]
        return request
    }
    
}

