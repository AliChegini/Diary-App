//
//  PermissionController.swift
//  DiaryApp
//
//  Created by Ehsan on 27/11/2018.
//  Copyright © 2018 Ali C. All rights reserved.
//

import UIKit
import CoreLocation

class PermissionController: UIViewController, LocationPermissionDelegate {
    
    lazy var locationManager: LocationManager = {
        return LocationManager(delegate: nil, permissionDelegate: self)
    }()
    
    func requestLocationPermission() {
        do {
            try locationManager.requestLocationAuthorization()
        } catch LocationError.disallowedByUser {
            // show alert to user
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    // MARK: Location Permission Delegate
    func authorizationSucceeded() {
        print("We have the location of the user")
    }
    
    func authorizationFailedWithStatus(_ status: CLAuthorizationStatus) {
        print("User did not granted location acceess \(status)")
    }
    
}




