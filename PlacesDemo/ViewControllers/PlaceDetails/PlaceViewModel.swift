//
//  PlaceViewModel.swift
//  PlacesDemo
//
//  Created by Daniel Sumara on 21.12.2017.
//  Copyright © 2017 Korson. All rights reserved.
//

import Foundation

public protocol PlaceDetailsViewModel {
    
    weak var view: PlaceDetailsView! { get set }
    
    func updateView()
    func persistPlace()
    
}
