//
//  Place+PlaceMO.swift
//  PlacesDemo
//
//  Created by Daniel Sumara on 23.12.2017.
//  Copyright © 2017 Korson. All rights reserved.
//

import Foundation

extension Place {
    
    init(from place: PlaceMO) {
        self.init(id: place.id, avatar: place.avatar, latitude: place.latitude, longitude: place.longitude, name: place.name)
    }
    
}
