//
//  MapView.swift
//  PlacesDemo
//
//  Created by Daniel Sumara on 21.12.2017.
//  Copyright © 2017 Korson. All rights reserved.
//

import Foundation

public protocol MapView: class {
    
    func set(_ coordinates: Coordinates)
    func set(_ places: [Place])
    
}
