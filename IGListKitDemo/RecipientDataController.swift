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
    private var identifier: Int64 = 0
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
    }
    
    func addRandomRecipient() {
        coreDataStack.performBackgroundTask { (context: NSManagedObjectContext) in
            let recipient = NSEntityDescription.insertNewObject(forEntityName: "Recipient", into: context) as! Recipient
            recipient.fistName = "Jan"
            recipient.lastName = "Kowalski"
            recipient.identifier = self.identifier
            
            do {
                try context.save()
                self.identifier += 1
            } catch {
                print(error)
            }
        }
    }
}
