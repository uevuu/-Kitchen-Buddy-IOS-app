//
//  FavouriteService.swift
//  Kitchen Buddy
//
//  Created by Nikita Marin on 04.06.2023.
//

import CoreData

final class FavouriteService {
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreData")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    private var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
}
