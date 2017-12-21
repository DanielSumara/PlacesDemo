//
//  Coordinates.swift
//  PlacesDemo
//
//  Created by Daniel Sumara on 21.12.2017.
//  Copyright © 2017 Korson. All rights reserved.
//

import Foundation
import MapKit

public struct Coordinates {
    
    // MARK:- Properties
    
    public let latitude: Double
    public let longitude: Double
    
    // MARK:- Lifecycle
    
    public init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
    
    public init(from coordinates: CLLocationCoordinate2D) {
        latitude = coordinates.latitude
        longitude = coordinates.longitude
    }
    
}
