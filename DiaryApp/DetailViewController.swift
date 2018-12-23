//
//  DetailViewController.swift
//  DiaryApp
//
//  Created by Ehsan on 21/11/2018.
//  Copyright © 2018 Ali C. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {

    var detailItem: Item?
    var context: NSManagedObjectContext!
    
    @IBOutlet weak var detailDescription: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let item = detailItem {
            detailDescription.text = item.text
        }
    }
    

    @IBAction func save(_ sender: Any) {
        if let item = detailItem, let newText = detailDescription.text {
            item.text = newText
            item.date = "Updated on \(Item.dateGenerator())"
            context.saveChanges()
            navigationController?.navigationController?.popViewController(animated: true)
        }
    }
    
    
    @IBAction func deleteItem(_ sender: Any) {
        if let item = detailItem {
            context.delete(item)
            context.saveChanges()
            navigationController?.navigationController?.popViewController(animated: true)
        }
    }

}
