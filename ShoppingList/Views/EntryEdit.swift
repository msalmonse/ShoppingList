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

    @Binding
    var productIndex: Int
    @Binding
    var storeIndex: Int
    let cancelDone: String

    init(
        _ entry: EditableEntry,
        context: NSManagedObjectContext,
        products: FetchedResults<Product>,
        stores: FetchedResults<Store>,
        productIndex: Binding<Int>,
        storeIndex: Binding<Int>
    ) {
        self.entry = entry
        self.managedObjectContext = context
        self.products = products
        self.stores = stores
        self._productIndex = productIndex
        self._storeIndex = storeIndex
        self.cancelDone = entry.isEdit ? "Cancel" : "Done"
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
            Spacer()
            StoreSelector(index: $storeIndex, stores: stores, category: nil)
            ProductSelector(index: $productIndex, products: products)
            InputText("Description", text: $entry.quantity, onCommit: { self.updateEntry() })
            Spacer()
            HStack {
                Button(
                    action: {
                        self.mode.wrappedValue.dismiss()
                    },
                    label: { EncapsulatedText(cancelDone) }
                )
                .buttonStyle(ShrinkPressed())
                Button(
                    action: { self.updateEntry() },
                    label: { EncapsulatedText(self.entry.label) }
                )
                .buttonStyle(ShrinkPressed())
                .disabled(self.entry.quantity.isEmpty && self.productIndex > 0)
            }
        }
    }
}
