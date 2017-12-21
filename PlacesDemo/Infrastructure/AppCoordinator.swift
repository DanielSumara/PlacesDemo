//
//  AppCoordinator.swift
//  PlacesDemo
//
//  Created by Daniel Sumara on 21.12.2017.
//  Copyright © 2017 Korson. All rights reserved.
//

import Foundation
import UIKit

final class AppCoordinator {
    
    // MARK:- Properties
    
    let application: UIApplication
    let window: UIWindow
    
    private lazy var rootViewController: UIViewController = self.createRootViewController()
    
    private lazy var mapViewController: UIViewController = self.createMapViewController()
    private lazy var lastPlacesViewControlle: UIViewController = self.createPlacesViewController()
    
    private lazy var locationService: LocationService = LocationServiceFactory().create()
    
    // MARK:- Lifecycle
    
    init(for application: UIApplication, using window: UIWindow) {
        self.application = application
        self.window = window
    }
    
    // MARK:- API
    
    func initialize() {
        window.rootViewController = rootViewController
        
        locationService.currentLocation {
            print("\t\t\($0))")
        }
    }
    
    // MARK:- Methods
    
    private func createRootViewController() -> UIViewController {
        let root = UITabBarController(nibName: nil, bundle: nil)
        root.viewControllers = [
            mapViewController,
            lastPlacesViewControlle
        ]
        return root
    }
    
    private func createMapViewController() -> UIViewController {
        let vc = MapViewController()
        vc.view.backgroundColor = .red
        
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem = UITabBarItem(for: .map)
        
        return nav
    }
    
    private func createPlacesViewController() -> UIViewController {
        let vc = UIViewController()
        vc.view.backgroundColor = .green
        
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem = UITabBarItem(for: .lastPlaces)
        
        return nav
    }
    
}
