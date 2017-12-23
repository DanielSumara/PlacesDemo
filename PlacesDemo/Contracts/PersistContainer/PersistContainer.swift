//
//  PersistContainer.swift
//  PlacesDemo
//
//  Created by Daniel Sumara on 23.12.2017.
//  Copyright © 2017 Korson. All rights reserved.
//

import Foundation

public protocol PersistContainer {
    
    func register(observer: PersistContainerObserver)
    
    func persist(place: Place)
    func fetchPlaces(completion: @escaping ([Place]) -> Void)
    
    func persistData()
    
}
