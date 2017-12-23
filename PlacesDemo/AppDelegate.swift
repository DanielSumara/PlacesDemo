//
//  AppDelegate.swift
//  PlacesDemo
//
//  Created by Daniel Sumara on 21.12.2017.
//  Copyright © 2017 Korson. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK:- Properties
    
    var coordinator: AppCoordinator?
    var window: UIWindow?
    
    // MARK:- UIApplicationDelegate

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        guard let window = window else { return false }
        
        coordinator = AppCoordinator(for: application, using: window)
        coordinator?.initialize()
        
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        coordinator?.persistData()
    }

}

