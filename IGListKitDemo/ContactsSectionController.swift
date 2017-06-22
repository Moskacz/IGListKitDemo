//
//  ContactsSectionController.swift
//  IGListKitDemo
//
//  Created by Michał Moskała on 22.06.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import IGListKit

class ContactsSectionController: ListSectionController {
    
    override func sizeForItem(at index: Int) -> CGSize {
        return CGSize(width: collectionContext!.containerSize.width, height: 40.0)
    }
    
    override func cellForItem(at index: Int) -> UICollectionViewCell {
        guard let cell = collectionContext?.dequeueReusableCell(withNibName: "ContactCell", bundle: Bundle.main, for: self, at: index) as? ContactCell else {
            fatalError("couldn't create contact cell")
        }
        
        cell.contactNameLabel.text = "\(index)"
        return cell
    }
}
