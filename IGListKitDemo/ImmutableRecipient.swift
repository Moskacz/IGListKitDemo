//
//  ImmutableRecipient.swift
//  IGListKitDemo
//
//  Created by Michał Moskała on 22.06.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import IGListKit

class ImmutableRecipient: ListDiffable {
    
    let creationTimeStamp: Double
    let firstName: String
    let lastName: String
    
    init(creationTimeStamp: Double, firstName: String, lastName: String) {
        self.creationTimeStamp = creationTimeStamp
        self.firstName = firstName
        self.lastName = lastName
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return NSNumber(value: creationTimeStamp)
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let toObject = object as? ImmutableRecipient else {
            return false
        }
        
        return (toObject.creationTimeStamp - creationTimeStamp) < Double.leastNonzeroMagnitude
    }
}
