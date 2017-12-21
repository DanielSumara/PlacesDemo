//
//  UIView+AutoLayouts.swift
//  PlacesDemo
//
//  Created by Daniel Sumara on 21.12.2017.
//  Copyright © 2017 Korson. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    public enum Anchor {
        
        case top
        case left
        case right
        case bottom
        
    }
    
    public func insert(into parent: UIView, at index: Int? = nil) {
        if let index = index {
            parent.insertSubview(self, at: index)
        } else {
            parent.addSubview(self)
        }
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    public func margin(anchor: Anchor, in parent: UIView, offset constant: CGFloat = 0) {
        switch anchor {
        case .top: topAnchor.constraint(equalTo: parent.layoutMarginsGuide.topAnchor, constant: constant).isActive = true
        case .left: leadingAnchor.constraint(equalTo: parent.layoutMarginsGuide.leadingAnchor, constant: constant).isActive = true
        case .right: parent.layoutMarginsGuide.trailingAnchor.constraint(equalTo: trailingAnchor, constant: constant).isActive = true
        case .bottom: bottomAnchor.constraint(equalTo: parent.layoutMarginsGuide.bottomAnchor, constant: constant).isActive = true
        }
    }
    
    public func centerHorizontally(in parent: UIView) {
        centerXAnchor.constraint(equalTo: parent.centerXAnchor).isActive = true
    }
    
    public func verticalSpace(to sibling: UIView, equal constant: CGFloat = 8) {
        sibling.topAnchor.constraint(equalTo: bottomAnchor, constant: constant).isActive = true
    }
    
    public func width(equalTo other: UIView, multiplier: CGFloat = 1) {
        widthAnchor.constraint(equalTo: other.widthAnchor, multiplier: multiplier).isActive = true
    }
    
    public func height(equalTo other: UIView, multiplier: CGFloat = 1) {
        heightAnchor.constraint(equalTo: other.heightAnchor, multiplier: multiplier).isActive = true
    }
    
}
