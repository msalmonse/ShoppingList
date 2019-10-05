//
//  QuantityExtension.swift
//  ShoppingList
//
//  Created by Michael Salmon on 2019-09-28.
//  Copyright © 2019 mesme. All rights reserved.
//

import Foundation
import CoreData

extension Quantity {
    func storeFilter(_ store: Store?) -> Bool {
        if store == nil { return true }
        // Check for no store selected, i.e. Any
        if (whichStore?.count ?? 0) == 0 { return true }
        return whichStore?.contains(store!) ?? true
    }

    var anyStore: Store? {
        guard let set = whichStore else { return nil }
        return set.anyObject() as? Store
    }
}

// Class for adding or editing quantities

class EditableQuantity: ObservableObject, Identifiable {
    let id = UUID()
    private var entry: Quantity?

    let isEdit: Bool
    let label: String

    @Published
    var category: Category?
    @Published
    var quantity: String
    @Published
    var whichProduct: Product?
    @Published
    var whichStore: Store?

    func update() {
        if entry != nil {
            entry!.category = whichProduct?.category
            entry!.completed = false
            entry!.quantity = quantity
            entry!.whichProduct = whichProduct
            entry!.whichStore = nil
            if whichStore != nil { entry!.addToWhichStore(whichStore!) }
            entry!.objectWillChange.send()
        }
    }

    func add(context: NSManagedObjectContext) {
        self.entry = Quantity(context: context)
        self.entry!.id = UUID()
        update()
    }

    init() {
        entry = nil
        category = nil
        isEdit = false
        label = "Add"
        quantity = ""
        whichProduct = nil
        whichStore = nil
    }

    init(_ entry: Quantity) {
        self.entry = entry
        category = entry.category
        isEdit = true
        label = "Update"
        quantity = entry.quantity ?? ""
        whichProduct = entry.whichProduct
        whichStore = entry.anyStore
    }
}
