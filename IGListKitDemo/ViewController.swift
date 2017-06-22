//
//  ViewController.swift
//  IGListKitDemo
//
//  Created by Michał Moskała on 22.06.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import UIKit
import IGListKit

class ViewController: UIViewController, ListAdapterDataSource, DataProviderDelegate {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    let coreDataStack = CoreDataStackImpl()
    var recipientDataProvider: RecipientDataProvider? = nil
    var recipientDataController: RecipientDataController? = nil
    var recipients: [ImmutableRecipient]? = nil
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipientDataProvider = RecipientDataProvider(coreDataStack: coreDataStack)
        recipientDataProvider?.delegate = self
        recipients = recipientDataProvider?.getRecipients()
        
        recipientDataController = RecipientDataController(coreDataStack: coreDataStack)
        
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }

    // MARK: ListAdapterDataSource
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        return recipients ?? []
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        return RecipientSectionController(recipient: object as! ImmutableRecipient)
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }
    
    // MARK: DataProviderDelegate
    
    func performUpdatesForCoreDataChange(animated: Bool) {
        recipients = recipientDataProvider?.getRecipients()
        adapter.performUpdates(animated: animated, completion: nil)
    }
    
    // MARK: UI Actions
    
    @IBAction func addRecipientButtonTapped(_ sender: UIButton) {
        recipientDataController?.addRandomRecipient()
    }
}

