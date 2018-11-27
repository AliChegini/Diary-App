//
//  LocationManager.swift
//  DiaryApp
//
//  Created by Ehsan on 27/11/2018.
//  Copyright © 2018 Ali C. All rights reserved.
//

import UIKit
import CoreLocation

enum LocationError : Error {
    case unknownError
    case disallowedByUser
    case unableToFindLocation
}


protocol LocationPermissionDelegate: class {
    func authorizationSucceeded()
    func authorizationFailedWithStatus(_ status: CLAuthorizationStatus)
}

protocol LocationManagerDelegate: class {
    func obtainedCoordinates(_ coordinate: Coordinate)
    func failedWithError(_ error: LocationError)
}


class LocationManager: NSObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    weak var permissionDelegate: LocationPermissionDelegate?
    weak var delegate: LocationManagerDelegate?
    
    init(delegate: LocationManagerDelegate?, permissionDelegate: LocationPermissionDelegate?) {
        self.delegate = delegate
        self.permissionDelegate = permissionDelegate
        super.init()
        
        manager.delegate = self
    }
    
    
    func requestLocationAuthorization() throws {
        let authorizationStatus = CLLocationManager.authorizationStatus()
        
        if authorizationStatus == .restricted || authorizationStatus == .denied {
            throw LocationError.disallowedByUser
        } else if authorizationStatus == .notDetermined {
            manager.requestWhenInUseAuthorization()
        } else {
            return
        }
    }
    
    
    func requestLocation() {
        manager.requestLocation()
    }
    
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            permissionDelegate?.authorizationSucceeded()
        } else {
            permissionDelegate?.authorizationFailedWithStatus(status)
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        guard let error = error as? CLError else {
            delegate?.failedWithError(.unknownError)
            return
        }
        
        switch error.code {
        case .locationUnknown, .network: delegate?.failedWithError(.unableToFindLocation)
        case .denied: delegate?.failedWithError(.disallowedByUser)
        default: return
        }
    }
    
    
    
}



