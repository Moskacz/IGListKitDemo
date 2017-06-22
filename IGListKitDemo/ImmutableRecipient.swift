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
    
    let identifier: Int64
    let firstName: String
    let lastName: String
    
    init(identifier: Int64, firstName: String, lastName: String) {
        self.identifier = identifier
        self.firstName = firstName
        self.lastName = lastName
    }
    
    func diffIdentifier() -> NSObjectProtocol {
        return NSNumber(value: identifier)
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let toObject = object as? ImmutableRecipient else {
            return false
        }
        
        return toObject.identifier == identifier
    }
}
