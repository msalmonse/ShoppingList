//
//  StoreExtra.swift
//  ShoppingList
//
//  Created by Michael Salmon on 2019-09-28.
//  Copyright © 2019 mesme. All rights reserved.
//

import Foundation
import CoreData

extension Store {
    var title: String {
        if branch == nil {
            return name!
        } else {
            return "\(name!) (\(branch!))"
        }
    }

    var allCategoryNames: [String] {
        if categories == nil { return [] }
        let set = categories as! Set<Category>      // swiftlint:disable:this force_cast
        return set.map({ $0.name! }).sorted()
    }
}

// Object to edit or add a store

class EditableStore: ObservableObject, Identifiable {
    let id = UUID()
    private var store: Store?

    let isEdit: Bool

    @Published
    var categories: Set<Category> = []
    @Published
    var branch: String
    let label: String
    @Published
    var name: String

    func update() {
        if store != nil {
            store!.name = name
            store!.branch = branch.isEmpty ? nil : branch
            store!.categories = nil
            if !categories.isEmpty { store!.addToCategories(categories as NSSet) }
            store!.objectWillChange.send()
        }
    }

    func add(context: NSManagedObjectContext) {
        self.store = Store(context: context)
        self.store!.id = UUID()
        update()
    }

    init() {
        store = nil
        branch = ""
        isEdit = false
        label = "Add"
        name = ""
    }

    init(_ store: Store) {
        self.store = store
        branch = store.branch ?? ""
        if let storedCategories = store.categories {
            categories = storedCategories as! Set<Category> // swiftlint:disable:this force_cast
        }
        isEdit = true
        label = "Update"
        name = store.name ?? ""
    }
}
