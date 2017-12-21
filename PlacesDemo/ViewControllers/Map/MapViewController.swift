//
//  MapViewController.swift
//  PlacesDemo
//
//  Created by Daniel Sumara on 21.12.2017.
//  Copyright © 2017 Korson. All rights reserved.
//

import Foundation
import MapKit

public final class MapViewController: UIViewController {
    
    // MARK:- Properties
    
    private lazy var mapView: MKMapView = MKMapView()
    
    // MARK:- Lifecycle
    
    public override func loadView() {
        view = mapView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Mapa"
    }
    
}
