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

    init(_ product: EditableProduct, context: NSManagedObjectContext) {
        self.product = product
        self.managedObjectContext = context
    }

    func updateProduct() {
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
