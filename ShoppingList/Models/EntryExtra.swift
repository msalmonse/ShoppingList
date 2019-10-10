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
    func combinedFilter(_ store: Store?, _ category: Category?) -> Bool {
        switch (category, store) {
            // Both nil? Always true
        case (nil, nil): return true
        case (nil, _):
            if (self.stores?.count ?? 0) == 0 { return true }
            return self.stores?.contains(store!) ?? true
        case (_, nil):
            if self.category == nil { return true }
            return self.category == category
        default:
            if self.category == nil { return combinedFilter(store, nil) }
            if (self.stores?.count ?? 0) == 0 { return combinedFilter(nil, category) }
            return self.category == category && (self.stores?.contains(store!) ?? true)
        }
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
