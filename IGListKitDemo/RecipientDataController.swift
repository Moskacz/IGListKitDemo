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
}
