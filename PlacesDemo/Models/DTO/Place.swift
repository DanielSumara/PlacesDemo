//
//  Place.swift
//  PlacesDemo
//
//  Created by Daniel Sumara on 21.12.2017.
//  Copyright © 2017 Korson. All rights reserved.
//

import Foundation

public struct Place: Codable {
    
    // MARK:- Properties
    
    public let id: String
    public let name: String
    public let avatar: String
    public let latitude: Double
    public let longitude: Double
    
    // MARK:- Lifecycle
    
    init(id: String, avatar: String, latitude: Double, longitude: Double, name: String) {
        self.id = id
        self.avatar = avatar
        self.latitude = latitude
        self.longitude = longitude
        self.name = name
    }
    
}

extension Place {
    
    public enum CodingKeys: String, CodingKey {
        case id
        case avatar
        case latitude = "lat"
        case longitude = "lng"
        case name
    }
    
}
