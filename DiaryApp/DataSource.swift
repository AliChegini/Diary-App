//
//  DataSource.swift
//  DiaryApp
//
//  Created by Ehsan on 26/11/2018.
//  Copyright © 2018 Ali C. All rights reserved.
//

import UIKit
import CoreData


class DataSource: NSObject, UITableViewDataSource {
    private let tableView: UITableView
    private let context: NSManagedObjectContext
    
    lazy var fetchedResultsController: DiaryFetchedResultsController = {
        return DiaryFetchedResultsController(managedObjectContext: self.context, tableView: self.tableView)
    }()
    
    
    init(tableView: UITableView, context: NSManagedObjectContext) {
        self.tableView = tableView
        self.context = context
    }
    
    func object(at indexPath: IndexPath) -> Item {
        return fetchedResultsController.object(at: indexPath)
    }
    
    
    // MARK: Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = fetchedResultsController.sections?[section] else {
            return 0
        }
        
        return section.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: MasterCell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as? MasterCell else {
            fatalError()
        }
        let item = fetchedResultsController.object(at: indexPath)
        
        cell.dateLabel.text = item.date
        cell.diaryText.text = item.text
        
        if let location = item.location {
            cell.location.text = location
        } else {
            cell.location.text = "Unknown Location"
        }
        
        if let img = item.imageData {
            cell.picture.image = UIImage(data: img as Data)
            cell.picture.setRounded()
        } else {
            cell.picture.image = UIImage(named: "icn_noimage")
        }
        
        if let mood = item.mood {
            switch mood {
            case "bad": cell.mood.image = UIImage(named: "icn_bad")
            case "average": cell.mood.image = UIImage(named: "icn_average")
            case "good": cell.mood.image = UIImage(named: "icn_happy")
            default:
                cell.mood.image = UIImage(named: "icn_noimage")
                break
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let item = fetchedResultsController.object(at: indexPath)
        context.delete(item)
        context.saveChanges()
    }
    
}


extension UIImageView {
    func setRounded() {
        self.layer.cornerRadius = (self.frame.width / 2)
        self.layer.masksToBounds = true
    }
}
