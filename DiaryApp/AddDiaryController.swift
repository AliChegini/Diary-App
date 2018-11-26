//
//  AddDiaryController.swift
//  DiaryApp
//
//  Created by Ehsan on 21/11/2018.
//  Copyright © 2018 Ali C. All rights reserved.
//

import UIKit
import CoreData

class AddDiaryController: UIViewController {
    
    // Will be used for dependency injection
    var managedObjectContext: NSManagedObjectContext!
    
    @IBOutlet weak var userInput: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func save(_ sender: Any) {
        guard let text = userInput.text, !text.isEmpty else {
            return
        }
        
        let item = NSEntityDescription.insertNewObject(forEntityName: "Item", into: managedObjectContext) as! Item
        item.text = text
        managedObjectContext.saveChanges()
        
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
