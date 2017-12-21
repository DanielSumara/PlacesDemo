//
//  Place.swift
//  PlacesDemo
//
//  Created by Daniel Sumara on 21.12.2017.
//  Copyright © 2017 Korson. All rights reserved.
//

import Foundation

public struct Place {
    
    // MARK:- Properties
    
    public let id: Int
    public let avatar: String
    public let latitude: Double
    public let longitude: Double
    public let name: String
    
    // MARK:- Lifecycle
    
    public init(id: Int, avatar: String, latitude: Double, longitude: Double, name: String) {
        self.id = id
        self.avatar = avatar
        self.latitude = latitude
        self.longitude = longitude
        self.name = name
    }
    
}
