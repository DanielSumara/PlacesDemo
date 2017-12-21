//
//  MenuItem.swift
//  PlacesDemo
//
//  Created by Daniel Sumara on 21.12.2017.
//  Copyright © 2017 Korson. All rights reserved.
//

import Foundation

public struct MenuItem {
    
    // MARK:- Properties
    
    public let title: String
    public let icon: Icon
    
    // MARK:- Lifecycle
    
    public init(_ title: String, icon: Icon = .empty) {
        self.title = title
        self.icon = icon
    }
    
}

extension MenuItem {
    
    public static let map: MenuItem = MenuItem("Mapa", icon: Icon(normal: Images.MenuIcons.Map.default, selected: Images.MenuIcons.Map.selected))
    public static let lastPlaces: MenuItem = MenuItem("Ostatnie", icon: Icon(normal: Images.MenuIcons.LastPlaces.default, selected: Images.MenuIcons.LastPlaces.selected))
    
}
