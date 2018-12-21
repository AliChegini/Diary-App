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
    
    var context: NSManagedObjectContext!
    
    
    override func setUp() {
        super.setUp()
        context = CoreDataStack().managedObjectContext
        var count = 0
        
        do {
            let request =  NSFetchRequest<Item>(entityName: "Item")
            count = try context.count(for: request)
            
        } catch {
            print(error)
        }
        
        print("context size after setup is \(count)")
    }
    
    override func tearDown() {
        context = nil
        super.tearDown()
    }
    
    

    func testCreation() {
        guard let item = NSEntityDescription.insertNewObject(forEntityName: "Item", into: context) as? Item else {
            return
        }
        
        item.text = "Test"
        item.date = "Monday"
        item.location = "New York"
        item.mood = "happy"
        context.saveChanges()
        do {
            let request =  NSFetchRequest<Item>(entityName: "Item")
            let array = try context.fetch(request)
            
        } catch {
            print(error)
        }
        
    }

}
