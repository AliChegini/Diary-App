//
//  DiaryAppTests.swift
//  DiaryAppTests
//
//  Created by Ehsan on 20/12/2018.
//  Copyright © 2018 Ali C. All rights reserved.
//

import CoreData
import XCTest
@testable import DiaryApp


class DiaryAppTests: XCTestCase {
    
    var context = CoreDataStack().managedObjectContext
    
    func testCreation() {
        guard let item = NSEntityDescription.insertNewObject(forEntityName: "Item", into: context) as? Item else {
            return
        }
        
        item.text = "TestObjectCreation"
        item.date = "Monday"
        item.location = "New York"
        item.mood = "happy"
        context.saveChanges()
        
        do {
            let request =  NSFetchRequest<Item>(entityName: "Item")
            request.returnsObjectsAsFaults = false
            let result = try context.fetch(request)
            // Checking if the new object is created successfully
            XCTAssertTrue(result.contains(item))
        } catch {
            print(error)
        }
    }
    
    
    func testDeletion() {
        guard let item = NSEntityDescription.insertNewObject(forEntityName: "Item", into: context) as? Item else {
            return
        }
        
        item.text = "TestObjectDeletion"
        item.date = "Monday"
        item.location = "New York"
        item.mood = "happy"
        context.saveChanges()
        
        context.delete(item)
        context.saveChanges()
        
        do {
            let request =  NSFetchRequest<Item>(entityName: "Item")
            request.returnsObjectsAsFaults = false
            let result = try context.fetch(request)
            // Checking if the new object is deleted successfully
            XCTAssertFalse(result.contains(item))
        } catch {
            print(error)
        }
    }
    
    
    func testEdition() {
        guard let item = NSEntityDescription.insertNewObject(forEntityName: "Item", into: context) as? Item else {
            return
        }
        
        item.text = "TestObjectEdition"
        item.date = "Monday"
        item.location = "New York"
        item.mood = "happy"
        context.saveChanges()
        
        item.text = "This text is the new text"
        context.saveChanges()
        
        do {
            let request =  NSFetchRequest<Item>(entityName: "Item")
            request.returnsObjectsAsFaults = false
            let result = try context.fetch(request)
            // Checking if the new object is edited successfully
            XCTAssertTrue(result.contains{ $0.text == "This text is the new text" })
        } catch {
            print(error)
        }
    }
    
    
    func testDateStamp() {
        guard let item = NSEntityDescription.insertNewObject(forEntityName: "Item", into: context) as? Item else {
            return
        }
        
        item.text = "TestObjectDateStamp"
        item.date = Item.dateGenerator()
        item.location = "New York"
        item.mood = "happy"
        context.saveChanges()
        
        do {
            let request =  NSFetchRequest<Item>(entityName: "Item")
            request.returnsObjectsAsFaults = false
            let result = try context.fetch(request)
            // Checking if the date is associated successfully
            XCTAssertTrue(result.contains{ $0.date == Item.dateGenerator() })
        } catch {
            print(error)
        }
        
    }
    
}
