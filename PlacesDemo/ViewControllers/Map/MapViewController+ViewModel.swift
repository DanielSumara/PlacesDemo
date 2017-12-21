//
//  MapViewController+ViewModel.swift
//  PlacesDemo
//
//  Created by Daniel Sumara on 21.12.2017.
//  Copyright © 2017 Korson. All rights reserved.
//

import Foundation

extension MapViewController {
    
    public final class ViewModel: MapViewModel {
        
        // MARK:- Properties
        
        public weak var view: MapView!
        
        private weak var coordinator: DetailsCoordinator!
        
        private let locationService: LocationService
        private let placeRepository: PlacesRepository!
        
        private var deviceLocalization: Coordinates?
        private var placesAround: [Place]?
        
        // MARK:- Lifecycle
        
        public init(coordinator: DetailsCoordinator, service: LocationService, repository: PlacesRepository!) {
            self.coordinator = coordinator
            
            locationService = service
            placeRepository = repository
        }
        
        // MARK:- MapViewModel
        
        public func updateView() {
            if let location = deviceLocalization {
                view.set(location)
                getPlaces(around: location)
                
                return
            }
            
            locationService.currentLocation { [weak self] deviceLocalization in
                guard let `self` = self else { return }

                self.deviceLocalization = deviceLocalization
                self.view.set(deviceLocalization)
                
                self.getPlaces(around: deviceLocalization)
            }
        }
        
        public func showDetails(for place: Place) {
            coordinator.showDetails(of: place)
        }
        
        // MARK:- Methods
        
        private func getPlaces(around coordinates: Coordinates) {
            if let places = placesAround {
                view.set(places)
                
                return
            }
            placeRepository.places(around: coordinates) { [weak self] places in
                guard let `self` = self else { return }

                self.placesAround = places
                self.view.set(places)
            }
        }
        
    }
    
}
