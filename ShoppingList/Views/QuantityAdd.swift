//
//  QuantityAdd.swift
//  ShoppingList
//
//  Created by Michael Salmon on 2019-09-28.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI

struct QuantityAdd: View {
    @Environment(\.managedObjectContext)
    var managedObjectContext

    @FetchRequest(
        entity: Product.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Product.name, ascending: true)
        ]
    )
    var products: FetchedResults<Product>

    @FetchRequest(
        entity: Store.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Store.name, ascending: true)
        ]
    )
    var stores: FetchedResults<Store>

    @State
    var productIndex = 0
    @State
    var storeIndex = -1
    @State
    var value = ""

    var body: some View {
        VStack {
            Picker(selection: $productIndex, label: Text("Product")) {
                ForEach(products.indices, id: \.self) { index in
                    Text(self.products[index].name ?? "").tag(index)
                }
            }

            Picker(selection: $storeIndex, label: Text("Store")) {
                Text("Any").tag(-1)
                ForEach(stores.indices, id: \.self) { index in
                    Text(self.stores[index].name ?? "").tag(index)
                }
            }

            TextField("Quantity", text: $value)
            Button(
                action: {
                    let quantity = Quantity(context: self.managedObjectContext)
                    quantity.id = UUID()
                    quantity.quantity = self.value
                    let product = self.products[self.productIndex]
                    quantity.addToWhichProcuct(product)
                    product.addToHowMuch(quantity)
                    if self.storeIndex >= 0 {
                        let store = self.stores[self.storeIndex]
                        quantity.addToWhichStore(store)
                        store.addToHowMuch(quantity)
                    }
                    self.managedObjectContext.persist()
                    self.value = ""
                },
                label: { Text("Add") }
            )
            .disabled(self.value.isEmpty || self.products.isEmpty)
        }
    }
}

struct QuantityAdd_Previews: PreviewProvider {
    static var previews: some View {
        QuantityAdd()
    }
}
