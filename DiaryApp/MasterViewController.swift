//
//  MasterViewController.swift
//  DiaryApp
//
//  Created by Ehsan on 21/11/2018.
//  Copyright © 2018 Ali C. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController {

    let managedObjectContext = CoreDataStack().managedObjectContext
    
    lazy var dataSource: DataSource = {
        return DataSource(tableView: tableView, context: self.managedObjectContext)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
    }
    
    
    // MARK: UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newItem" {
            
            guard let navigationController = segue.destination as? UINavigationController, let addDiaryController = navigationController.topViewController as? AddDiaryController else {
                return
            }
            addDiaryController.managedObjectContext = self.managedObjectContext
            
        } else if segue.identifier == "showDetail" {
            
            guard let navigationController = segue.destination as? UINavigationController, let dvc = navigationController.topViewController as? DetailViewController, let indexPath = tableView.indexPathForSelectedRow else {
                return
            }
            let item = dataSource.object(at: indexPath)
            dvc.detailItem = item
            dvc.context = self.managedObjectContext
        }
    }

    
}



