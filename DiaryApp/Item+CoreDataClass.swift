//
//  Item+CoreDataClass.swift
//  DiaryApp
//
//  Created by Ehsan on 22/11/2018.
//  Copyright © 2018 Ali C. All rights reserved.
//
//

import Foundation
import CoreData

public class Item: NSManagedObject {
    @NSManaged public var text: String
    @NSManaged public var imageData: NSData?
    @NSManaged public var mood: String?
    @NSManaged public var date: String
    @NSManaged public var location: String?
}
