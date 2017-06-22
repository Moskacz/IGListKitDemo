//
//  RecipientsSectionController.swift
//  IGListKitDemo
//
//  Created by Michał Moskała on 22.06.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import IGListKit

class RecipientSectionController: ListSectionController {
    
    var recipient: ImmutableRecipient
    
    init(recipient: ImmutableRecipient) {
        self.recipient = recipient
    }
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 55.0)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: "RecipientCell", bundle: Bundle.main, for: self, at: index) as? RecipientCell else {
            fatalError("couldn't create recipient cell")
        }
        
        cell.recipientNameLabel.text = recipient.firstName.appending(" ").appending(recipient.lastName)
        return cell
    }
    
    override func didUpdate(to object: Any) {
        recipient = object as! ImmutableRecipient
    }
}
