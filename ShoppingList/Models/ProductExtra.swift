//
//  ProductExtra.swift
//  ShoppingList
//
//  Created by Michael Salmon on 2019-09-28.
//  Copyright © 2019 mesme. All rights reserved.
//

import Foundation
import CoreData

extension Product {
    var title: String {
        if manufacturer == nil {
            return name!
        } else {
            return "\(name!) (\(manufacturer!))"
        }
    }
}

// Object to edit or add a product

class EditableProduct: ObservableObject, Identifiable {
    let id = UUID()
    private var product: Product?

    let isEdit: Bool

    @Published
    var category: Category?
    @Published
    var categoryIndex = -1
    let label: String
    @Published
    var manufacturer: String
    @Published
    var name: String

    func update() {
        if product != nil {
            if product!.category != category {
                // Remove from old category
                product!.category?.removeFromProducts(product!)
                product!.category = category
                // Add to new category
                category?.addToProducts(product!)
            }
            product!.manufacturer = manufacturer.isEmpty ? nil : manufacturer
            product!.name = name
            product!.objectWillChange.send()
        }
    }

    func add(context: NSManagedObjectContext) {
        self.product = Product(context: context)
        self.product!.id = UUID()
        update()
    }

    init() {
        product = nil
        manufacturer = ""
        isEdit = false
        label = "Add"
        name = ""
    }

    init(_ product: Product, categoryIndex: Int) {
        self.product = product
        category = product.category
        self.categoryIndex = categoryIndex
        isEdit = true
        label = "Update"
        manufacturer = product.manufacturer ?? ""
        name = product.name ?? ""
    }
}
