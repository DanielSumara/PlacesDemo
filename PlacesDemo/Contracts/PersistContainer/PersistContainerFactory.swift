//
//  PersistContainerFactory.swift
//  PlacesDemo
//
//  Created by Daniel Sumara on 23.12.2017.
//  Copyright © 2017 Korson. All rights reserved.
//

import CoreData
import Foundation

public final class PersistContainerFactory {
    
    public func create() -> PersistContainer {
        return CoreDataContainer()
    }
    
}

final class CoreDataContainer: PersistContainer {
    
    // MARK:- Properties
    
    private let queue: DispatchQueue = DispatchQueue(label: "CoreDataContainer", qos: .userInteractive, attributes: .concurrent)
    
    private lazy var persistentContainer = self.createContainer()
    private lazy var context: NSManagedObjectContext = self.persistentContainer.viewContext
    private lazy var resultsController = self.createResultsController()
    private lazy var delegate = Delegate(for: self)
    
    private var results: [PlaceMO]?
    
    // MARK:- PersistContainer
    
    func register(observer: PersistContainerObserver) {
        delegate.register(observer: observer)
    }
    
    func persist(place: Place) {
        if results == nil {
            fetchData()
        }
        
        guard let results = results else { fatalError() }
        
        if results.first(where: { $0.id == place.id }) != nil {
            return
        }
        
        // INFO:
        // Dodawanie i modyfikowanie obiektów powinno odbywać się na wątku "dziecku",
        // następnie powinno zostać zapisane do kontekstu głównego.
        // Ze względu na "wagę" operacji w tym projekcie, nie ma sensu tego robić ;)
        _ = PlaceMO(in: context, from: place)
        
        // INFO:
        // Kontest nie powinnien być zapisywany po każdej operacji.
        // Zapis powinien odbywać się po zakończeniu zbioru operacji lub przed wyjściem z aplikacji.
        // Ze względu na "wage" zapisu w tym projekcie, nie ma sensu tego implementować ;)
        persistData()
    }
    
    func fetchPlaces(completion: @escaping ([Place]) -> Void) {
        queue.async(flags: .barrier) { [weak self] in
            guard let `self` = self else { return }

            if let results = self.results {
                completion(results.map { Place(from: $0) })
                return
            }
            
            self.fetchData()
            self.fetchPlaces(completion: completion)
        }
    }
    
    func persistData() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }

    }
    
    // MARK:- Methods
    
    private func fetchData() {
        do {
            try self.resultsController.performFetch()
            self.results = self.resultsController.fetchedObjects ?? []
        } catch {
            fatalError()
        }
    }
    
    private func createResultsController() -> NSFetchedResultsController<PlaceMO> {
        let request = NSFetchRequest<PlaceMO>()
        request.entity = NSEntityDescription.entity(forEntityName: "PlaceMO", in: context)
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(PlaceMO.name), ascending: true)]
        let controller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = delegate
        return controller
    }
    
    private func createContainer() -> NSPersistentContainer {
        let container = NSPersistentContainer(name: "PlacesDemo")
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }
    
}

extension CoreDataContainer {
    
    final class Delegate: NSObject, NSFetchedResultsControllerDelegate {
        
        // MARK:- Properties
        
        private weak var container: CoreDataContainer!
        
        private var observers: [Wrapper] = []
        
        // MARK:- Lifecycle
        
        init(for container: CoreDataContainer) {
            self.container = container
        }
        
        // MARK:- API
        
        func register(observer: PersistContainerObserver) {
            observers.append(Wrapper(for: observer))
        }
        
        // MARK:- NSFetchedResultsControllerDelegate
        
        func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
            guard let object = anObject as? PlaceMO else { return }
            
            if let indexPath = newIndexPath {
                container.results?.insert(object, at: indexPath.row)
            } else {
                container.results?.append(object)
            }
            
            for observer in observers {
                if let observer = observer.observer {
                    observer.container(container, didAdd: Place(from: object))
                }
            }
        }
        
    }
    
}

extension CoreDataContainer.Delegate {
    
    private struct Wrapper {
        
        // MARK:- Properties
        
        weak var observer: PersistContainerObserver?
        
        // MARK:- Lifecycle
        
        init(for observer: PersistContainerObserver) {
            self.observer = observer
        }
        
    }
    
}
