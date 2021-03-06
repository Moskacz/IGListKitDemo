//
//  RecipientDataController.swift
//  IGListKitDemo
//
//  Created by Michał Moskała on 22.06.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import CoreData

class RecipientDataController {
    
    private let coreDataStack: CoreDataStack
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
    }
    
    func addRandomRecipient() {
        coreDataStack.performBackgroundTask { (context: NSManagedObjectContext) in
            let recipient = NSEntityDescription.insertNewObject(forEntityName: "Recipient", into: context) as! Recipient
            recipient.fistName = "Jan"
            recipient.lastName = "Kowalski"
            recipient.creationTimeStamp = Date().timeIntervalSince1970
            
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }
    
    func removeRandomRecipient() {
        if let object = coreDataStack.getViewContext().registeredObjects.first {
            coreDataStack.getViewContext().delete(object)
            do {
                try coreDataStack.getViewContext().save()
            } catch {
                print("error")
            }
        }
    }
    
    func reorderFirstRecipient() {
        guard let recipients = coreDataStack.getViewContext().registeredObjects as? Set<Recipient> else {
            return
        }
        
        let sortedRecipients = recipients.sorted { (lhs:Recipient, rhs:Recipient) -> Bool in
            return lhs.creationTimeStamp < rhs.creationTimeStamp
        }
        
        sortedRecipients.first?.creationTimeStamp = Date().timeIntervalSince1970
    }
}
