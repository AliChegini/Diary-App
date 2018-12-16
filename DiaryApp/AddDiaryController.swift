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
    
    // used for dependency injection
    var managedObjectContext: NSManagedObjectContext!
    
    let permissionController = PermissionController()
    
    lazy var locationManager: LocationManager = {
       return LocationManager(delegate: self, permissionDelegate: nil)
    }()

    var coordinate: Coordinate?
    
    @IBOutlet weak var userInput: UITextField!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var imagePickerButton: UIButton!
    
    
    lazy var photoPickerManager: PhotoPickerManager = {
       let manager = PhotoPickerManager(presentingViewController: self)
        manager.delegate = self
        return manager
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // should be put in a function or extension
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        let convertedDate = dateFormatter.string(from: Date())
        
        date.text = convertedDate

    }
    
    @IBAction func launchCamera(_ sender: Any) {
        photoPickerManager.presentPhotoPicker(animated: true)
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
    

    
    @IBAction func requestLocation(_ sender: Any) {
        permissionController.requestLocationPermission()
        locationManager.requestLocation()
    }
    
}


extension AddDiaryController: LocationManagerDelegate {
    func obtainedCoordinates(_ coordinate: Coordinate) {
        self.coordinate = coordinate
        print("Coordinate is: \(coordinate)")
    }
    
    func failedWithError(_ error: LocationError) {
        print("Error: \(error)")
    }
    
    
}


extension AddDiaryController: PhotoPickerManagerDelegate {
    func manager(_ manager: PhotoPickerManager, didPickImage image: UIImage) {
        manager.dismissPhotoPicker(animated: true, completion: nil)
    }
}
