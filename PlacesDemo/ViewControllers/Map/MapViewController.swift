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

    private var viewModel: MapViewModel
    
    // MARK:- Lifecycle
    
    public init(with viewModel: MapViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.view = self
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func loadView() {
        view = mapView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Mapa"
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.updateView()
        
        mapView.showsUserLocation = true
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        mapView.showsUserLocation = false
    }
    
}

extension MapViewController: MapView {
    
    public func set(_ coordinates: Coordinates) {
        mapView.setCenter(CLLocationCoordinate2D(from: coordinates), animated: true)
    }
    
    public func set(_ places: [Place]) {
        
    }
    
}
