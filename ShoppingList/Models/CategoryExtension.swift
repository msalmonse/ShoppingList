//
//  CategoryExtension.swift
//  ShoppingList
//
//  Created by Michael Salmon on 2019-10-01.
//  Copyright © 2019 mesme. All rights reserved.
//

import Foundation
import CoreData

extension Category {
    var title: String { return name ?? "" }
}

// Class used to edit or add a category

class EditableCategory: ObservableObject, Identifiable {
    let id = UUID()
    var category: Category?

    let isEdit: Bool

    let label: String
    @Published
    var name: String

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

// Class for CategoriesSelector

class CategoriesSet {
    let categories: [Category]
    var hasCategory: Set<Category>

    var indices: Range<Int> { return categories.indices }

    init(_ categories: [Category], hasCategory: Set<Category>) {
        self.categories = categories
        self.hasCategory = hasCategory
    }

    subscript(index: Int) -> Category { return categories[index] }

    subscript(index: Category) -> Bool {
        get { return hasCategory.contains(index) }
        set {
            if newValue {
                hasCategory.insert(index)
            } else {
                hasCategory.remove(index)
            }
        }
    }
}
