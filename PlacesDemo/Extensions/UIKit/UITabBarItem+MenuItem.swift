//
//  UITabBarItem+MenuItem.swift
//  PlacesDemo
//
//  Created by Daniel Sumara on 21.12.2017.
//  Copyright © 2017 Korson. All rights reserved.
//

import Foundation
import UIKit

extension UITabBarItem {
    
    convenience init(for menuItem: MenuItem) {
        self.init(title: menuItem.title, image: menuItem.icon.normal, selectedImage: menuItem.icon.selected)
    }
    
}
