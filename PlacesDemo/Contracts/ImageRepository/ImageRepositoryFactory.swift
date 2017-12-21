//
//  ImageRepositoryFactory.swift
//  PlacesDemo
//
//  Created by Daniel Sumara on 21.12.2017.
//  Copyright © 2017 Korson. All rights reserved.
//

import Foundation
import UIKit

public final class ImageRepositoryFactory {
    
    public func create() -> ImageRepository {
        return NetworkImageRepository(session: .shared)
    }
    
}

final class NetworkImageRepository: ImageRepository {
    
    // MARK:- Properties
    
    private let session: URLSession
    private let queue: DispatchQueue = DispatchQueue(label: "NetworkImageRepository", qos: .userInteractive, attributes: .concurrent)
    
    private var tasks: [String: URLSessionDataTask] = [:]
    private var requests: [String: [(UIImage) -> Void]] = [:]
    private var cache: [String: UIImage] = [:]
    
    // MARK:- Lifecycle
    
    init(session: URLSession) {
        self.session = session
    }
    
    // MARK:- ImageRepository
    
    func image(from address: String, completion: @escaping (UIImage) -> Void) {
        queue.async(flags: .barrier) { [weak self] in
            guard let `self` = self else { return }
            
            if let image = self.cache[address] {
                DispatchQueue.main.async {
                    completion(image)
                }
                return
            }
            
            self.requests[address, default: []].append(completion)
            self.createTaskIfNeeded(for: address)
        }
    }
    
    // MARK:- Methods
    
    private func createTaskIfNeeded(for address: String) {
        guard requests[address] != nil else { return }
        
        tasks[address] = session.dataTask(with: url(for: address), completionHandler: { [weak self] (data, response, error) in
            guard let `self` = self else { return }
            
            if let error = error { self.handle(error) }
            
            guard let data = data else { fatalError() }
            guard let image = UIImage(data: data) else { fatalError() }
            
            self.compleatRequest(for: address, with: image)
        })
        tasks[address]?.resume()
    }
    
    private func url(for address: String) -> URL {
        guard let url = URL(string: address) else { fatalError() }
        return url
    }
    
    private func handle(_ error: Error) {
        fatalError(error.localizedDescription)
    }
    
    private func compleatRequest(for address: String, with image: UIImage) {
        queue.async(flags: .barrier) { [weak self] in
            guard let `self` = self else { return }
            
            guard let requests = self.requests[address] else { return }
            self.requests[address] = nil
            self.cache[address] = image
            
            DispatchQueue.main.async {
                requests.forEach { $0(image) }
            }
        }
    }
    
}
