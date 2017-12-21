//
//  Icon.swift
//  PlacesDemo
//
//  Created by Daniel Sumara on 21.12.2017.
//  Copyright © 2017 Korson. All rights reserved.
//

import Foundation
import UIKit

public struct Icon {
    
    // MARK:- Properties
    
    public let normal: UIImage
    public let selected: UIImage
    
    // MARK:- Lifecycle
    
    public init(normal: UIImage, selected: UIImage) {
        self.normal = normal
        self.selected = selected
    }
    
}

extension Icon {
    
    public static var empty: Icon { return Icon(normal: UIImage(), selected: UIImage()) }
    
}
