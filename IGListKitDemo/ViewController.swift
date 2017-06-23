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
    
    var coreDataStack: CoreDataStack!
    let contactsDataProvider = ContactsDataProvider()
    var recipientDataProvider: RecipientDataProvider? = nil
    var recipientDataController: RecipientDataController? = nil
    var recipients = [ImmutableRecipient]()
    var contacts = [ImmutableContact]()
    
    lazy var adapter: ListAdapter = {
        return ListAdapter(updater: ListAdapterUpdater(), viewController: self)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipientDataProvider = RecipientDataProvider(coreDataStack: coreDataStack)
        recipientDataProvider?.delegate = self
        recipients = recipientDataProvider?.getRecipients() ?? []
        recipientDataController = RecipientDataController(coreDataStack: coreDataStack)
        adapter.collectionView = collectionView
        adapter.dataSource = self
    }

    // MARK: ListAdapterDataSource
    
    func objects(for listAdapter: ListAdapter) -> [ListDiffable] {
        var data = [ListDiffable]()
        data += (recipients as [ListDiffable])
        data += (contacts as [ListDiffable])
        return data
    }
    
    func listAdapter(_ listAdapter: ListAdapter, sectionControllerFor object: Any) -> ListSectionController {
        if object is ImmutableRecipient {
            return RecipientSectionController(recipient: object as! ImmutableRecipient)
        } else {
            return ContactsSectionController(contact: object as! ImmutableContact)
        }
    }
    
    func emptyView(for listAdapter: ListAdapter) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }
    
    // MARK: DataProviderDelegate
    
    func performUpdatesForCoreDataChange(animated: Bool) {
        recipients = recipientDataProvider?.getRecipients() ?? []
        adapter.performUpdates(animated: animated, completion: nil)
    }
    
    // MARK: UI Actions
    
    @IBAction func addRecipientButtonTapped(_ sender: UIButton) {
        recipientDataController?.addRandomRecipient()
    }
    
    @IBAction func askForPhoneBookAccess(_ sender: UIButton) {
        contactsDataProvider.requestForAccess { (granted: Bool) in
            guard granted else { return }
            self.contacts = self.contactsDataProvider.getContacts() ?? []
            self.adapter.performUpdates(animated: true, completion: nil)
        }
    }
    
    @IBAction func deleteRecipientButtonTapped(_sender: UIButton) {
        recipientDataController?.removeRandomRecipient()
    }
}

