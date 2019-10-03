//
//  ProductEdit.swift
//  ShoppingList
//
//  Created by Michael Salmon on 2019-10-02.
//  Copyright © 2019 mesme. All rights reserved.
//

import CoreData
import SwiftUI

struct ProductEdit: View {
    @Environment(\.presentationMode)
    var mode: Binding<PresentationMode>

    @ObservedObject
    var product: EditableProduct
    var managedObjectContext: NSManagedObjectContext
    var categories: FetchedResults<Category>

    init(
        _ product: EditableProduct,
        context: NSManagedObjectContext,
        categories: FetchedResults<Category>
    ) {
        self.product = product
        self.managedObjectContext = context
        self.categories = categories
    }

    func updateProduct() {
        let index = product.categoryIndex
        product.category = categories.indices.contains(index) ? categories[index] : nil
        if product.isEdit {
            product.update()
        } else {
            product.add(context: managedObjectContext)
        }
        managedObjectContext.persist()
        mode.wrappedValue.dismiss()
    }

    var body: some View {
        VStack {
            TextField(
                "Product name",
                text: $product.name,
                onCommit: { self.updateProduct() }
            )
            TextField(
                "Product manufacturer",
                text: $product.manufacturer,
                onCommit: { self.updateProduct() }
            )
            CategorySelector(index: $product.categoryIndex, categories: categories)
            HStack {
                Button(
                    action: {
                        self.mode.wrappedValue.dismiss()
                    },
                    label: { Text("Cancel") }
                )
                Button(
                    action: { self.updateProduct() },
                    label: { Text(self.product.label) }
                )
                .disabled(self.product.name.isEmpty)
            }
        }
        .padding(.horizontal, 20)
    }
}
