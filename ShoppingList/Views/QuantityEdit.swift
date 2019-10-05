//
//  EntryEdit.swift
//  ShoppingList
//
//  Created by Michael Salmon on 2019-10-04.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI
import CoreData

struct EntryEdit: View {
    @Environment(\.presentationMode)
    var mode: Binding<PresentationMode>

    @ObservedObject
    var entry: EditableEntry
    var managedObjectContext: NSManagedObjectContext
    var products: FetchedResults<Product>
    var stores: FetchedResults<Store>

    @State
    var productIndex = 0
    @Binding
    var storeIndex: Int

    init(
        _ entry: EditableEntry,
        context: NSManagedObjectContext,
        products: FetchedResults<Product>,
        stores: FetchedResults<Store>,
        storeIndex: Binding<Int>
    ) {
        self.entry = entry
        self.managedObjectContext = context
        self.products = products
        self.stores = stores
        self._storeIndex = storeIndex
    }

    func updateEntry() {
        entry.product =
            products.indices.contains(productIndex) ? products[productIndex] : nil
        entry.stores =
            stores.indices.contains(storeIndex) ? stores[storeIndex] : nil
        if entry.isEdit {
            entry.update()
        } else {
            entry.add(context: managedObjectContext)
        }
        managedObjectContext.persist()
        if entry.isEdit { mode.wrappedValue.dismiss() }
    }

    var body: some View {
        VStack {
            StoreSelector(index: $storeIndex, stores: stores)
            ProductSelector(index: $productIndex, products: products)
            TextField("Quantity", text: $entry.quantity)
            HStack {
                Button(
                    action: {
                        self.mode.wrappedValue.dismiss()
                    },
                    label: { Text("Cancel") }
                )
                Button(
                    action: { self.updateEntry() },
                    label: { Text(self.entry.label) }
                )
                .disabled(self.entry.quantity.isEmpty)
            }
            Spacer()
            Button(
                action: { self.mode.wrappedValue.dismiss() },
                label: { Text("Done") }
            )
        }
    }
}
