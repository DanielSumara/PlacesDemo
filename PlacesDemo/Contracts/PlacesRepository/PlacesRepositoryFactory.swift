//
//  PlacesRepositoryFactory.swift
//  PlacesDemo
//
//  Created by Daniel Sumara on 21.12.2017.
//  Copyright © 2017 Korson. All rights reserved.
//

import Foundation

public final class PlacesRepositoryFactory {
    
    public func create() -> PlacesRepository {
        return RESTPlacesRepository(session: .shared)
    }
    
}

final class RESTPlacesRepository: PlacesRepository {
    
    // MARK:- Properties
    
    private let session: URLSession
    private let queue: DispatchQueue = DispatchQueue(label: "RESTPlacesRepository", qos: .userInteractive, attributes: .concurrent)
    
    private var tasks: [Coordinates: URLSessionDataTask] = [:]
    private var requests: [Coordinates: [([Place]) -> Void]] = [:]
    
    // MARK:- Lifecycle
    
    init(session: URLSession) {
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
    
    private func createTaskIfNeeded(for location: Coordinates) {
        guard requests[location] != nil else { return }
        
        tasks[location] = session.dataTask(with: url(for: location), completionHandler: { [weak self] (data, response, error) in
            guard let `self` = self else { return }
            
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
            
            requests.forEach { $0(places) }
        }
    }
    
}
