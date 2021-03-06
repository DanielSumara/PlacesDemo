//
//  PersistContainerObserver.swift
//  PlacesDemo
//
//  Created by Daniel Sumara on 23.12.2017.
//  Copyright © 2017 Korson. All rights reserved.
//

import Foundation

public protocol PersistContainerObserver: class {
    
    func container(_ container: PersistContainer, didAdd object: Place)
    
}
