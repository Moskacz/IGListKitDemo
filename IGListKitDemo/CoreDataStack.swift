//
//  CoreDataStack.swift
//  IGListKitDemo
//
//  Created by Michał Moskała on 22.06.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import CoreData

protocol CoreDataStack {
    func getViewContext() -> NSManagedObjectContext
    func performBackgroundTask(withBlock block: @escaping ((NSManagedObjectContext) -> Void))
}

class CoreDataStackImpl: CoreDataStack {
    
    private let container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "IGListKitDemo")
        container.loadPersistentStores(completionHandler: { (description: NSPersistentStoreDescription, error: Error?) in
            if let loadError = error {
                fatalError("couldn't load persistent store")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        return container
    }()
    
    func getViewContext() -> NSManagedObjectContext {
        return container.viewContext
    }
    
    func performBackgroundTask(withBlock block: @escaping ((NSManagedObjectContext) -> Void)) {
        container.performBackgroundTask(block)
    }
}
