//
//  PlaceListViewModel.swift
//  PlacesDemo
//
//  Created by Daniel Sumara on 23.12.2017.
//  Copyright © 2017 Korson. All rights reserved.
//

import Foundation

public protocol PlaceListViewModel {
    
    weak var view: PlaceListView! { get set }
    
    func loadData()
    
    var numberOfItems: Int { get }
    func model(for index: Int) -> Place
    
    func selectPlace(at index: Int)
    
}
