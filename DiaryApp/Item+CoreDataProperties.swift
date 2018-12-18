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
    
    class func with(_ image: UIImage, in context: NSManagedObjectContext) -> Item {
        let item = NSEntityDescription.insertNewObject(forEntityName: "Item", into: context) as! Item
        
        // I am not sure if it is OK to only save the image and not the rest of the properties!
        item.imageData = image.jpegData(compressionQuality: 1.0)! as NSData

        return item
    }
    
    
}

