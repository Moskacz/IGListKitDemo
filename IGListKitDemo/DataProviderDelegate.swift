//
//  DataProviderDelegate.swift
//  IGListKitDemo
//
//  Created by Michał Moskała on 22.06.2017.
//  Copyright © 2017 Michal Moskala. All rights reserved.
//

import Foundation

protocol DataProviderDelegate: class {
    func performUpdatesForCoreDataChange(animated: Bool)
}
