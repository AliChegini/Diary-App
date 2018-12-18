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

    
    @IBOutlet weak var userInput: UITextField!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var imagePickerButton: UIButton!
    @IBOutlet weak var locationButton: UIButton!
    
    var location: String?
    
    // store property to keep a reference of the picked image
    var pickedImage = UIImage()
    
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
        
        guard let item = NSEntityDescription.insertNewObject(forEntityName: "Item", into: managedObjectContext) as? Item else {
            return
        }
        
        guard let text = userInput.text, !text.isEmpty else {
            return
        }
        
        if let nsdataImage = pickedImage.jpegData(compressionQuality: 1.0) as NSData? {
            item.imageData = nsdataImage
        }
    
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
    
    func obtainedLocation(_ address: String) {
        self.location = address
        locationButton.setTitle(address, for: .normal)
    }
    
    func failedWithError(_ error: LocationError) {
        print("Error: \(error)")
    }
}


extension AddDiaryController: PhotoPickerManagerDelegate {
    func manager(_ manager: PhotoPickerManager, didPickImage image: UIImage) {
        pickedImage = image
        imagePickerButton.setImage(image, for: .normal)
        
        manager.dismissPhotoPicker(animated: true, completion: nil)
    }
}
