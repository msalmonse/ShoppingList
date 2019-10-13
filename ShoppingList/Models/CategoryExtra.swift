//
//  CategoryExtra.swift
//  ShoppingList
//
//  Created by Michael Salmon on 2019-10-01.
//  Copyright © 2019 mesme. All rights reserved.
//

import Foundation
import CoreData

extension Category {
    var title: String { return name ?? "" }

    /// Check to see if the store contains us
    /// - Parameter store: Optional Store
    func storeFilter(_ store: Store?) -> Bool {
        if store == nil { return true }
        if store!.categories == nil { return true }
        if store!.categories!.count == 0 { return true }
        return store!.categories!.contains(self)
    }
}

// Class used to edit or add a category

class EditableCategory: ObservableObject, Identifiable {
    let id = UUID()
    var category: Category?

    let isEdit: Bool

    let label: String
    @Published
    var name: String

    /// Update category from the class
    func update() {
        if category != nil {
            category!.name = name
            category!.objectWillChange.send()
        }
    }

    func add(context: NSManagedObjectContext) {
        self.category = Category(context: context)
        self.category!.id = UUID()
        update()
    }

    init() {
        category = nil
        isEdit = false
        label = "Add"
        name = ""
    }

    init(_ category: Category) {
        self.category = category
        isEdit = true
        label = "Update"
        name = category.name ?? ""
    }
}

// List for CategoriesSelector

class HasCategory: ObservableObject, Identifiable {
    let id = UUID()
    let category: Category
    @Published
    var included: Bool
    let name: String

    init(_ category: Category, _ included: Bool) {
        self.category = category
        self.included = included
        self.name = category.name ?? "???"
    }
}

typealias HasCategoryList = [HasCategory]
