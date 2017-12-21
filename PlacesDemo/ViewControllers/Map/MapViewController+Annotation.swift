//
//  MapViewController+Annotation.swift
//  PlacesDemo
//
//  Created by Daniel Sumara on 21.12.2017.
//  Copyright © 2017 Korson. All rights reserved.
//

import Foundation
import MapKit

extension MapViewController {
    
    final class Annotation: NSObject, MKAnnotation {
        
        // MARK:- Properties
        
        let place: Place
        
        let coordinate: CLLocationCoordinate2D
        let title: String?
        
        // MARK:- Lifecycle
        
        init(from place: Place) {
            self.place = place
            
            coordinate = CLLocationCoordinate2D(from: place)
            title = place.name
        }
        
    }
    
}
