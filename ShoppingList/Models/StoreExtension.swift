//
//  StoreExtension.swift
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
}

// Object to edit or add a store

class EditableStore: ObservableObject, Identifiable {
    let id = UUID()
    private var store: Store?

    var isEdit: Bool { return store != nil }

    @Published
    var branch: String
    let label: String
    @Published
    var name: String

    func update() {
        if store != nil {
            store!.name = name
            store!.branch = branch
            store!.objectWillChange.send()
        }
    }

    func add(_ store: Store) {
        self.store = store
        self.store!.id = UUID()
        update()
    }

    init() {
        store = nil
        branch = ""
        label = "Add"
        name = ""
    }

    init(_ store: Store) {
        self.store = store
        branch = store.branch ?? ""
        label = "Update"
        name = store.name ?? ""
    }
}
