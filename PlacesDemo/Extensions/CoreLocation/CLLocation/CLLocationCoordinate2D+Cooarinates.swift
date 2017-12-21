//
//  CLLocationCoordinate2D+Cooarinates.swift
//  PlacesDemo
//
//  Created by Daniel Sumara on 21.12.2017.
//  Copyright © 2017 Korson. All rights reserved.
//

import CoreLocation
import Foundation

extension CLLocationCoordinate2D {
    
    init(from coordinates: Coordinates) {
        self.init(latitude: coordinates.latitude, longitude: coordinates.longitude)
    }
    
}
