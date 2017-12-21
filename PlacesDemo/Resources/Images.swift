//
//  Images.swift
//  PlacesDemo
//
//  Created by Daniel Sumara on 21.12.2017.
//  Copyright © 2017 Korson. All rights reserved.
//

import Foundation
import UIKit

struct Images {
    
    struct MenuIcons {
        
        struct Map {
            
            static let `default`: UIImage = UIImage(named: "TabBarIconsMap", in: Bundle(for: ClassForBundle.self), compatibleWith: nil)!
            
            static let selected: UIImage = UIImage(named: "TabBarIconsMapSelected", in: Bundle(for: ClassForBundle.self), compatibleWith: nil)!
            
            
            
        }
        
        struct LastPlaces {
            
            static let `default`: UIImage = UIImage(named: "TabBarIconsLastPlaces", in: Bundle(for: ClassForBundle.self), compatibleWith: nil)!
            
            static let selected: UIImage = UIImage(named: "TabBarIconsLastPlacesSelected", in: Bundle(for: ClassForBundle.self), compatibleWith: nil)!
            
        }
        
    }
    
}

extension Images {
    
    fileprivate final class ClassForBundle { }
    
}
