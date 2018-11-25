//
//  DiaryFetchedResultsController.swift
//  DiaryApp
//
//  Created by Ehsan on 24/11/2018.
//  Copyright © 2018 Ali C. All rights reserved.
//

import UIKit
import CoreData


class DiaryFetchedResultsController: NSFetchedResultsController<Item>, NSFetchedResultsControllerDelegate {
    private let tableView: UITableView
    
    init(managedObjectContext: NSManagedObjectContext, tableView: UITableView) {
        self.tableView = tableView
        super.init(fetchRequest: Item.fetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        self.delegate = self
        
        tryFetch()
    }
    
    func tryFetch() {
        do {
            try performFetch()
        } catch {
            print("Unresolved error: \(error.localizedDescription)")
        }
    }
    
    // MARK: FetchedResultsController delegate
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
    
    
}




