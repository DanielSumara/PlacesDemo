//
//  PlaceListViewController+ViewModel.swift
//  PlacesDemo
//
//  Created by Daniel Sumara on 23.12.2017.
//  Copyright © 2017 Korson. All rights reserved.
//

import Foundation

extension PlaceListViewController {
    
    public final class ViewModel: PlaceListViewModel {
        
        // MARK:- Properties
        
        public weak var view: PlaceListView!
        
        public var numberOfItems: Int { return dataSource.count }
        
        private let persistContainer: PersistContainer
        private let datailsCoordinator: DetailsCoordinator
        
        private var dataSource: [Place] = []
        
        // MARK:- Lifecycle
        
        public init(persistContainer: PersistContainer, detailsCoordinator: DetailsCoordinator) {
            self.persistContainer = persistContainer
            self.datailsCoordinator = detailsCoordinator
        }
        
        // MARK:- PlaceListViewModel
        
        public func loadData() {
            persistContainer.fetchPlaces { [weak self] (places) in
                guard let `self` = self else { return }

                self.dataSource = places
                
                DispatchQueue.main.async {
                    self.view.reload()
                }
            }
        }
        
        public func model(for index: Int) -> Place {
            return dataSource[index]
        }
        
        public func selectPlace(at index: Int) {
            datailsCoordinator.showDetails(of: dataSource[index])
        }
        
    }
    
}
