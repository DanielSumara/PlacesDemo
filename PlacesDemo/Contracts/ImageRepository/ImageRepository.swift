//
//  ImageRepository.swift
//  PlacesDemo
//
//  Created by Daniel Sumara on 21.12.2017.
//  Copyright © 2017 Korson. All rights reserved.
//

import Foundation
import UIKit

public protocol ImageRepository {
    
    func image(from: String, completion: @escaping (UIImage) -> Void)
    
}
