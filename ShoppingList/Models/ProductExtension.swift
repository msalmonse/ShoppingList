//
//  ProductExtension.swift
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
            return "\(manufacturer!) \(name!)"
        }
    }
}

// Object to edit or add a product

class EditableProduct: ObservableObject, Identifiable {
    let id = UUID()
    private var product: Product?

    let isEdit: Bool

    @Published
    var manufacturer: String
    let label: String
    @Published
    var name: String

    func update() {
        if product != nil {
            product!.name = name
            product!.manufacturer = manufacturer.isEmpty ? nil : manufacturer
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

    init(_ product: Product) {
        self.product = product
        manufacturer = product.manufacturer ?? ""
        isEdit = true
        label = "Update"
        name = product.name ?? ""
    }
}
