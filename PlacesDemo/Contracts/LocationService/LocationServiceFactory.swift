//
//  LocationServiceFactory.swift
//  PlacesDemo
//
//  Created by Daniel Sumara on 21.12.2017.
//  Copyright © 2017 Korson. All rights reserved.
//

import CoreLocation
import Foundation

public final class LocationServiceFactory {
    
    public func create() -> LocationService {
        return CLLocationService()
    }
    
}

final class CLLocationService: NSObject, CLLocationManagerDelegate, LocationService {
    
    //MARK:- Properties
    
    private let manager = CLLocationManager()
    private var requests: [(Coordinates) -> Void] = []
    
    private let queue: DispatchQueue = DispatchQueue(label: "CLLocationService", qos: .userInteractive, attributes: .concurrent)
    
    // MARK:- Lifecycle
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    // MARK:- LocationService
    
    func currentLocation(completion: @escaping (Coordinates) -> Void) {
        queue.async(flags: .barrier) { [weak self] in
            guard let `self` = self else { return }
            self.requests.append(completion)
        }
        
        runService()
    }
    
    // MARK:- CLLocationManagerDelegate
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard [CLAuthorizationStatus.authorizedAlways, .authorizedWhenInUse].contains(status) else { return }
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        
        queue.async(flags: .barrier) { [weak self] in
            guard let `self` = self else { return }
            
            let requests = self.requests
            self.requests = []
            
            DispatchQueue.main.async {
                requests.forEach { $0(Coordinates(from: location)) }
            }
        }
    }
    
    // MARK:- Methods
    
    private func runService() {
        guard CLLocationManager.locationServicesEnabled() else { return }
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined: manager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse: manager.startUpdatingLocation()
        case .authorizedAlways: break
        default:
            fatalError("You haven't valid configuration")
        }
    }
}
