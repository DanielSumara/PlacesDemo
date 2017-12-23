//
//  PlacesRepositoryFactory.swift
//  PlacesDemo
//
//  Created by Daniel Sumara on 21.12.2017.
//  Copyright © 2017 Korson. All rights reserved.
//

import Foundation
import UIKit

public final class PlacesRepositoryFactory {
    
    // MARK:- Properties
    
    private let application: UIApplication
    private let session: URLSession
    
    // MARK:- Lifecycle
    
    init(application: UIApplication = .shared, session: URLSession = .shared) {
        self.application = application
        self.session = session
    }
    
    public func create() -> PlacesRepository {
        return RESTPlacesRepository(application: application, session: session)
    }
    
}

final class RESTPlacesRepository: PlacesRepository {
    
    // MARK:- Properties
    
    private let application: UIApplication
    private let session: URLSession
    private let queue: DispatchQueue = DispatchQueue(label: "RESTPlacesRepository", qos: .userInteractive, attributes: .concurrent)
    
    private var tasks: [Coordinates: URLSessionDataTask] = [:]
    private var requests: [Coordinates: [([Place]) -> Void]] = [:]
    
    private var runningTasksNumber = 0 { didSet { updateNetworkActivityIndicatorStatus() } }
    
    // MARK:- Lifecycle
    
    init(application: UIApplication, session: URLSession) {
        self.application = application
        self.session = session
    }
    
    // MARK:- PlacesRepository
    
    func places(around location: Coordinates, completion: @escaping ([Place]) -> Void) {
        queue.async(flags: .barrier) { [weak self] in
            guard let `self` = self else { return }
            
            self.requests[location, default: []].append(completion)
            self.createTaskIfNeeded(for: location)
        }
    }
    
    // MARK:- Methods
    
    private func updateNetworkActivityIndicatorStatus() {
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            self.application.isNetworkActivityIndicatorVisible = self.runningTasksNumber > 0
        }
    }
    
    private func createTaskIfNeeded(for location: Coordinates) {
        guard requests[location] != nil else { return }
        
        tasks[location] = session.dataTask(with: url(for: location), completionHandler: { [weak self] (data, response, error) in
            guard let `self` = self else { return }
            
            self.runningTasksNumber -= 1
            
            if let error = error { self.handle(error) }
            guard let data = data else { fatalError() }
            do {
                let places = try JSONDecoder().decode([Place].self, from: data)
                self.compleatRequest(for: location, with: places)
            } catch {
                self.handle(error)
            }
        })
        tasks[location]?.resume()
        runningTasksNumber += 1
    }
    
    private func url(for location: Coordinates) -> URL {
        guard let url = URL(string: "https://interview-ready4s.herokuapp.com/geo?lat=\(location.latitude)&lng=\(location.longitude)") else { fatalError() }
        return url
    }
    
    private func handle(_ error: Error) {
        fatalError(error.localizedDescription)
    }
    
    private func compleatRequest(for location: Coordinates, with places: [Place]) {
        queue.async(flags: .barrier) { [weak self] in
            guard let `self` = self else { return }
            
            guard let requests = self.requests[location] else { return }
            self.requests[location] = nil
            
            DispatchQueue.main.async {
                requests.forEach { $0(places) }
            }
        }
    }
    
}
