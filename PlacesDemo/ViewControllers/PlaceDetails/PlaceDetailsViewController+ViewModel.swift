//
//  PlaceDetailsViewController+ViewModel.swift
//  PlacesDemo
//
//  Created by Daniel Sumara on 21.12.2017.
//  Copyright © 2017 Korson. All rights reserved.
//

import Foundation

extension PlaceDetailsViewController {
    
    public final class ViewModel: PlaceDetailsViewModel {
        
        // MARK:- Properties
        
        public var view: PlaceDetailsView!
        
        private let place: Place
        
        private let imageRepository: ImageRepository
        
        // MARK:- Lifecycle
        
        public init(for place: Place, using imageRepository: ImageRepository) {
            self.place = place
            self.imageRepository = imageRepository
        }
        
        // MARK:- PlaceDetailsViewModel
        
        public func updateView() {
            view.set(title: place.name)
            view.set(coordinates: Coordinates(from: place))
            
            imageRepository.image(from: place.avatar) { [weak self] (image) in
                guard let `self` = self else { return }

                self.view.set(image: image)
            }
        }
        
    }
    
}
