//
//  PlaceDetailsViewController+View.swift
//  PlacesDemo
//
//  Created by Daniel Sumara on 21.12.2017.
//  Copyright © 2017 Korson. All rights reserved.
//

import Foundation
import UIKit

extension PlaceDetailsViewController {
    
    final class View: UIView {
        
        // MARK:- Properties
        
        private lazy var image = self.createImage()
        private lazy var latitudeKey = self.keyLabel("Szerokość")
        private lazy var latitudeValue = self.valueLabel()
        private lazy var longitudeKey = self.keyLabel("Długość")
        private lazy var longitudeValue = self.valueLabel()
        
        // MARK:- Lifecycle
        
        // MARK:- API
        
        func initialize() {
            backgroundColor = .white
            
            image.insert(into: self)
            image.margin(anchor: .top, in: self, offset: 16)
            image.centerHorizontally(in: self)
            image.width(equalTo: self, multiplier: 0.9)
            image.height(equalTo: self, multiplier: 0.4)
            
            longitudeKey.insert(into: self)
            longitudeKey.margin(anchor: .left, in: self)
            longitudeKey.margin(anchor: .right, in: self)
            
            image.verticalSpace(to: longitudeKey)
            
            longitudeValue.insert(into: self)
            longitudeValue.margin(anchor: .left, in: self)
            longitudeValue.margin(anchor: .right, in: self)
            
            longitudeKey.verticalSpace(to: longitudeValue)
            
            latitudeKey.insert(into: self)
            latitudeKey.margin(anchor: .left, in: self)
            latitudeKey.margin(anchor: .right, in: self)
            
            longitudeValue.verticalSpace(to: latitudeKey)
            
            latitudeValue.insert(into: self)
            latitudeValue.margin(anchor: .left, in: self)
            latitudeValue.margin(anchor: .right, in: self)
            
            latitudeKey.verticalSpace(to: latitudeValue)
        }
        
        func set(image: UIImage) {
            self.image.image = image
        }
        
        func set(coordinates: Coordinates) {
            latitudeValue.text = "\(coordinates.latitude)"
            longitudeValue.text = "\(coordinates.longitude)"
        }
        
        // MARK:- Methods
        
        private func createImage() -> UIImageView {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            return imageView
        }
        
        private func keyLabel(_ text: String) -> UILabel {
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)
            label.text = text
            return label
        }
        
        private func valueLabel() -> UILabel {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
            label.textAlignment = .right
            return label
        }
        
    }
    
}
