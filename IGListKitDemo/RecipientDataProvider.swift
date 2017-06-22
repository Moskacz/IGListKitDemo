//
//  RecipientDataProvider.swift
//  IGListKitDemo
//
//  Created by Michał Moskała on 22.06.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import CoreData

class RecipientDataProvider: NSObject, NSFetchedResultsControllerDelegate {
    
    private let coreDataStack: CoreDataStack
    public weak var delegate: DataProviderDelegate?
    
    lazy var recipientsFRC: NSFetchedResultsController<Recipient> = {
        let fetchRequest: NSFetchRequest<Recipient> = Recipient.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "creationTimeStamp", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest,
                                             managedObjectContext: self.coreDataStack.getViewContext(),
                                             sectionNameKeyPath: nil,
                                             cacheName: nil)
        frc.delegate = self
        return frc
    }()
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        super.init()
        do {
            try recipientsFRC.performFetch()
        } catch {
            print(error)
        }
    }
    
    func getRecipients() -> [ImmutableRecipient]? {
        guard let recipients = recipientsFRC.fetchedObjects else { return nil }
        return recipients.flatMap { ImmutableRecipient(creationTimeStamp: $0.creationTimeStamp, firstName: $0.fistName, lastName: $0.lastName) }
    }
    
    // MARK: NSFetchedResultsControllerDelegate
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.performUpdatesForCoreDataChange(animated: true)
    }
}
