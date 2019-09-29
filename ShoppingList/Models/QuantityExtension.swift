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
        // Check for no store selected, i.e. Any
        if (whichStore?.count ?? 0) == 0 { return true }
        return whichStore?.contains(store!) ?? true
    }

    var anyProduct: Product? {
        guard let set = whichProcuct else { return nil }
        return set.anyObject() as? Product
    }

    var anyStore: Store? {
        guard let set = whichStore else { return nil }
        return set.anyObject() as? Store
    }
}
