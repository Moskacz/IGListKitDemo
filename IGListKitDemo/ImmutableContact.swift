//
//  ImmutableContact.swift
//  IGListKitDemo
//
//  Created by Michał Moskała on 22.06.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import IGListKit

class ImmutableContact: ListDiffable {
    
    let displayName: String
    
    init(displayName: String) {
        self.displayName = displayName
    }
    
    // MARK: ListDiffable
    
    func diffIdentifier() -> NSObjectProtocol {
        return displayName as NSString
    }
    
    func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
        guard let toObject = object as? ImmutableContact else { return false }
        return toObject.displayName == displayName
    }
}
