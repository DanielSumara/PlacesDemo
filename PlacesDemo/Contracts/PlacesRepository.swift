//
//  PlacesRepository.swift
//  PlacesDemo
//
//  Created by Daniel Sumara on 21.12.2017.
//  Copyright © 2017 Korson. All rights reserved.
//

import Foundation

public protocol PlacesRepository {
    
    func places(around location: Coordinates, completion: @escaping () -> [Place])
    
}
