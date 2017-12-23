//
//  PlaceMO.swift
//  PlacesDemo
//
//  Created by Daniel Sumara on 23.12.2017.
//  Copyright © 2017 Korson. All rights reserved.
//

import CoreData
import Foundation

public final class PlaceMO: NSManagedObject {
    
    // MARK:- Properties
    
    @NSManaged public var id: String
    @NSManaged public var name: String
    @NSManaged public var avatar: String
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    
    // MARK:- Lifecycle
    
    convenience init(in moc: NSManagedObjectContext, from place: Place) {
        self.init(entity: PlaceMO.entity(), insertInto: moc)
        
        id = place.id
        avatar = place.avatar
        name = place.name
        latitude = place.latitude
        longitude = place.longitude
    }
    
}
