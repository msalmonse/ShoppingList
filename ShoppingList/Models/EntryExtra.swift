//
//  EntryExtra.swift
//  ShoppingList
//
//  Created by Michael Salmon on 2019-09-28.
//  Copyright © 2019 mesme. All rights reserved.
//

import Foundation
import CoreData

extension Entry {
    func storeFilter(_ store: Store?) -> Bool {
        if store == nil { return true }
        // Check for no store selected, i.e. Any
        if (stores?.count ?? 0) == 0 { return true }
        return stores?.contains(store!) ?? true
    }

    var anyStore: Store? {
        guard let set = stores else { return nil }
        return set.anyObject() as? Store
    }
}

// Class for adding or editing quantities

class EditableEntry: ObservableObject, Identifiable {
    let id = UUID()
    private var entry: Entry?

    let isEdit: Bool
    let label: String

    @Published
    var category: Category?
    @Published
    var quantity: String
    @Published
    var product: Product?
    @Published
    var stores: Store?

    func update() {
        if entry != nil {
            entry!.category = product?.category
            entry!.completed = false
            entry!.quantity = quantity
            entry!.product = product
            entry!.stores = nil
            if stores != nil { entry!.addToStores(stores!) }
            entry!.objectWillChange.send()
        }
    }

    func add(context: NSManagedObjectContext) {
        self.entry = Entry(context: context)
        self.entry!.id = UUID()
        update()
    }

    init() {
        entry = nil
        category = nil
        isEdit = false
        label = "Add"
        quantity = ""
        product = nil
        stores = nil
    }

    init(_ entry: Entry) {
        self.entry = entry
        category = entry.category
        isEdit = true
        label = "Update"
        quantity = entry.quantity ?? ""
        product = entry.product
        stores = entry.anyStore
    }
}
