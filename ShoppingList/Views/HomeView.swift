//
//  HomeView.swift
//  ShoppingList
//
//  Created by Michael Salmon on 2019-09-28.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI

struct HomeView: View {
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
        entity: Quantity.entity(),
        sortDescriptors: []
    )
    var entries: FetchedResults<Quantity>

    @FetchRequest(
        entity: Store.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Store.name, ascending: true)
        ]
    )
    var stores: FetchedResults<Store>

    @State
    var storeIndex = -1

    func selectedStore() -> Store? {
        if !stores.indices.contains(storeIndex) { return nil }
        return stores[storeIndex]
    }

    @State
    var trigger = false

    var body: some View {
        VStack(alignment: .leading) {
            SelectedStoreView(index: $storeIndex, stores: stores)
            List(entries.filter({ $0.storeFilter(selectedStore()) }), id: \.self) {
                EntryRow(entry: $0)
            }
            HStack {
                Spacer()
                Button(
                    action: { self.trigger = true },
                    label: { Text("New Entry") }
                )
                Spacer()
                Text("").hidden()
                .sheet(isPresented: $trigger) {
                    QuantityEdit(
                        EditableQuantity(),
                        context: self.managedObjectContext,
                        products: self.products,
                        stores: self.stores,
                        storeIndex: self.$storeIndex
                    )
                }
            }
        }
    }
}

struct EntryRow: View {
    @Environment(\.managedObjectContext)
    var managedObjectContext
    @ObservedObject
    var entry: Quantity
    var product: Product?
    var store: Store?

    init(entry: Quantity) {
        self.entry = entry
        self.product = entry.whichProduct
        self.store = entry.anyStore
    }

    var body: some View {
        HStack {
            Button(
                action: {
                    self.entry.completed.toggle()
                    self.entry.objectWillChange.send()
                    self.managedObjectContext.persist()
                },
                label: {
                    Image(systemName: self.entry.completed ? "star.fill" : "star" )
                    .foregroundColor(.yellow)
                    .frame(width: 20, height: 20)
                    .clipShape(Rectangle())
                }
            )
            Text(entry.quantity ?? "")
            Text(product?.title ?? "")
            Text("@" + (store?.title ?? "Any"))
        }
    }
}

struct SelectedStoreView: View {
    @Binding
    var index: Int
    let stores: FetchedResults<Store>

    @State
    var trigger: Bool = false

    func storeTitle() -> String {
        if !stores.indices.contains(index) { return "Any" }
        return stores[index].title
    }

    var body: some View {
        HStack {
            Button(
                action: { self.trigger = true },
                label: { Text("Store: \(storeTitle())") }
            )
            Spacer()
            Text(">")

            Text("").hidden()
            .sheet(isPresented: $trigger) {
                StoreSelectorSheet(index: self.$index, stores: self.stores)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
