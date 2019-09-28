//
//  QuantityExtension.swift
//  ShoppingList
//
//  Created by Michael Salmon on 2019-09-28.
//  Copyright © 2019 mesme. All rights reserved.
//

import Foundation

extension Quantity {
    func storeFilter(_ store: Store?) -> Bool {
        if store == nil { return true }
        return whichStore?.contains(store!) ?? true
    }
}
