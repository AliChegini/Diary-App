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
    
    lazy var fetchedResultsController: DiaryFetchedResultsController = {
        return DiaryFetchedResultsController(managedObjectContext: self.managedObjectContext, tableView: self.tableView)
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Error fetching Item objects: \(error.localizedDescription)")
        }
        
    }
    
    // MARK: Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = fetchedResultsController.sections?[section] else {
            return 0
        }
        
        return section.numberOfObjects
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        
        return configureCell(cell, at: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let item = fetchedResultsController.object(at: indexPath)
        managedObjectContext.delete(item)
        managedObjectContext.saveChanges()
    }
    
    
    private func configureCell(_ cell: UITableViewCell, at indexPath: IndexPath) -> UITableViewCell {
        let item = fetchedResultsController.object(at: indexPath)
        
        cell.textLabel?.text = item.text
        return cell
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
            let item = fetchedResultsController.object(at: indexPath)
            dvc.detailItem = item
            dvc.context = self.managedObjectContext
        }
    }

    
}



