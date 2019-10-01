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
    let category: Category?

    let label: String
    @Published
    var name: String

    func update(_ context: NSManagedObjectContext) {
        if category != nil {
            category!.name = name
            category!.objectWillChange.send()
        } else {
            let newCategory = Category(context: context)
            newCategory.id = UUID()
            newCategory.name = name
        }
        context.persist()
    }

    init() {
        category = nil
        label = "Add"
        name = ""
    }

    init(_ category: Category) {
        self.category = category
        label = "Update"
        name = category.name ?? ""
    }
}
