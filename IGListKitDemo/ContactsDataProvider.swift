//
//  ContactsDataProvider.swift
//  IGListKitDemo
//
//  Created by Michał Moskała on 22.06.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation
import Contacts

class ContactsDataProvider {
    
    let store = CNContactStore()
    
    func requestForAccess(completion: @escaping ((Bool) -> Void)) {
        store.requestAccess(for: .contacts) { (granted: Bool, error: Error?) in
            if let accessError = error {
                print(accessError)
            }
            completion(granted)
        }
    }
    
    func getContacts() -> [ImmutableContact]? {
        guard CNContactStore.authorizationStatus(for: .contacts) == .authorized else { return nil }
        
        let keys: [CNKeyDescriptor] = [CNContactGivenNameKey as NSString,
                                       CNContactMiddleNameKey as NSString,
                                       CNContactFamilyNameKey as NSString]

        do {
            let containers = try store.containers(matching: nil)
            let contacts = containers.map({ (container: CNContainer) -> [CNContact] in
                let predicate = CNContact.predicateForContactsInContainer(withIdentifier: container.identifier)
                do {
                    return try store.unifiedContacts(matching: predicate, keysToFetch: keys)
                } catch {
                    return []
                }
            }).flatMap { $0}
            
            return contacts.map { (contact: CNContact) -> ImmutableContact in
                let nameComponents = [contact.givenName, contact.middleName, contact.familyName].filter { !$0.isEmpty }
                let displayName = nameComponents.joined(separator: " ")
                return ImmutableContact(displayName: displayName)
            }
        } catch {
            print(error)
            return nil
        }
    }
}
