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
    
    private lazy var rootViewController: UITabBarController = self.createRootViewController()
    
    private lazy var mapViewController: UIViewController = self.createMapViewController()
    private lazy var lastPlacesViewControlle: UIViewController = self.createPlacesViewController()
    
    private lazy var locationService: LocationService = LocationServiceFactory().create()
    private lazy var placesRepository: PlacesRepository = PlacesRepositoryFactory().create()
    private lazy var imageRepository: ImageRepository = ImageRepositoryFactory().create()
    
    // MARK:- Lifecycle
    
    init(for application: UIApplication, using window: UIWindow) {
        self.application = application
        self.window = window
    }
    
    // MARK:- API
    
    func initialize() {
        window.rootViewController = rootViewController
    }
    
    // MARK:- Methods
    
    private func createRootViewController() -> UITabBarController {
        let root = UITabBarController(nibName: nil, bundle: nil)
        root.viewControllers = [
            mapViewController,
            lastPlacesViewControlle
        ]
        return root
    }
    
    private func createMapViewController() -> UIViewController {
        let viewModel = MapViewController.ViewModel(coordinator: self, service: locationService, repository: placesRepository)
        let vc = MapViewController(with: viewModel)
        
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

extension AppCoordinator: DetailsCoordinator {
    
    func showDetails(of place: Place) {
        let viewModel = PlaceDetailsViewController.ViewModel(for: place, using: imageRepository)
        let vc = PlaceDetailsViewController(with: viewModel)
        rootViewController.selectedViewController?.show(vc, sender: self)
    }
    
}
