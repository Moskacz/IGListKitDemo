//
//  Recipient+CoreDataProperties.swift
//  IGListKitDemo
//
//  Created by Michał Moskała on 22.06.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import CoreData


extension Recipient {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Recipient> {
        return NSFetchRequest<Recipient>(entityName: "Recipient")
    }

    @NSManaged public var fistName: String
    @NSManaged public var lastName: String
    @NSManaged public var creationTimeStamp: Double

}
