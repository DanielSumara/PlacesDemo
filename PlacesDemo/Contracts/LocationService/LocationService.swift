//
//  LocationService.swift
//  PlacesDemo
//
//  Created by Daniel Sumara on 21.12.2017.
//  Copyright © 2017 Korson. All rights reserved.
//

import CoreLocation
import Foundation

public protocol LocationService {
    
    func currentLocation(completion: @escaping (Coordinates) -> Void)
    
}
