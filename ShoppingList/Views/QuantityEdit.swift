//
//  QuantityEdit.swift
//  ShoppingList
//
//  Created by Michael Salmon on 2019-10-04.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI
import CoreData

struct QuantityEdit: View {
    @Environment(\.presentationMode)
    var mode: Binding<PresentationMode>

    @ObservedObject
    var quantity: EditableQuantity
    var managedObjectContext: NSManagedObjectContext
    var products: FetchedResults<Product>
    var stores: FetchedResults<Store>

    @State
    var productIndex = 0
    @Binding
    var storeIndex: Int

    init(
        _ quantity: EditableQuantity,
        context: NSManagedObjectContext,
        products: FetchedResults<Product>,
        stores: FetchedResults<Store>,
        storeIndex: Binding<Int>
    ) {
        self.quantity = quantity
        self.managedObjectContext = context
        self.products = products
        self.stores = stores
        self._storeIndex = storeIndex
    }

    func updateQuantity() {
        quantity.whichProduct =
            products.indices.contains(productIndex) ? products[productIndex] : nil
        quantity.whichStore =
            stores.indices.contains(storeIndex) ? stores[storeIndex] : nil
        if quantity.isEdit {
            quantity.update()
        } else {
            quantity.add(context: managedObjectContext)
        }
        managedObjectContext.persist()
        if quantity.isEdit { mode.wrappedValue.dismiss() }
    }

    var body: some View {
        VStack {
            StoreSelector(index: $storeIndex, stores: stores)
            ProductSelector(index: $productIndex, products: products)
            TextField("Quantity", text: $quantity.quantity)
            HStack {
                Button(
                    action: {
                        self.mode.wrappedValue.dismiss()
                    },
                    label: { Text("Cancel") }
                )
                Button(
                    action: { self.updateQuantity() },
                    label: { Text(self.quantity.label) }
                )
                .disabled(self.quantity.quantity.isEmpty)
            }
            Spacer()
            Button(
                action: { self.mode.wrappedValue.dismiss() },
                label: { Text("Done") }
            )
        }
    }
}
