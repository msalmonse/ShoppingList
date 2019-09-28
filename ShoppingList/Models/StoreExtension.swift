//
//  StoreExtension.swift
//  ShoppingList
//
//  Created by Michael Salmon on 2019-09-28.
//  Copyright © 2019 mesme. All rights reserved.
//

import Foundation

extension Store {
    var title: String {
        if branch == nil {
            return name!
        } else {
            return "\(name!) (\(branch!))"
        }
    }
}
