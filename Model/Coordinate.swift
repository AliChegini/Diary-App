//
//  Coordinate.swift
//  DiaryApp
//
//  Created by Ehsan on 27/11/2018.
//  Copyright © 2018 Ali C. All rights reserved.
//

import CoreLocation

struct Coordinate {
    let latitude: Double
    let longitude: Double
}


extension Coordinate {
    init(location: CLLocation) {
        self.latitude = location.coordinate.latitude
        self.longitude = location.coordinate.longitude
    }
}

