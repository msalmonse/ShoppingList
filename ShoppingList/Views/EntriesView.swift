//
//  EntriesView.swift
//  ShoppingList
//
//  Created by Michael Salmon on 2019-09-28.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI

struct EntriesView: View {
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
        entity: Entry.entity(),
        sortDescriptors: []
    )
    var entries: FetchedResults<Entry>

    @FetchRequest(
        entity: Store.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Store.name, ascending: true)
        ]
    )
    var stores: FetchedResults<Store>

    @State
    var storeIndex = -1

    @State
    var trigger = false

    func removeCompleted() {
        _ = entries.filter({ $0.completed }).map { self.managedObjectContext.delete($0) }
    }

    func selectedStore() -> Store? {
        if !stores.indices.contains(storeIndex) { return nil }
        return stores[storeIndex]
    }

    var body: some View {
        VStack(alignment: .leading) {
            SelectedStoreView(index: $storeIndex, stores: stores)
            List(entries.filter({ $0.storeFilter(selectedStore()) }), id: \.self) {
                EntryRow(
                    entry: $0,
                    products: self.products,
                    stores: self.stores
                )
            }
            HStack {
                Spacer()
                Button(
                    action: { self.removeCompleted() },
                    label: { Text("Remove Completed") }
                )
                Spacer()
                Button(
                    action: { self.trigger = true },
                    label: { Text("New Entry") }
                )
                Spacer()
                Text("").hidden()
                .sheet(isPresented: $trigger) {
                    EntryEdit(
                        EditableEntry(),
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
    var entry: Entry
    var product: Product?
    var products: FetchedResults<Product>
    var store: Store?
    var stores: FetchedResults<Store>

    @State
    var storeIndex = -1
    @State
    var trigger = false

    init(
        entry: Entry,
        products: FetchedResults<Product>,
        stores: FetchedResults<Store>
    ) {
        self.entry = entry
        self.product = entry.product
        self.products = products
        self.store = entry.anyStore
        self.stores = stores
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
            Spacer()
            Button(
                action: {
                    self.storeIndex =
                        self.store == nil ? -1 : (self.stores.firstIndex(of: self.store!) ?? -1)
                    self.trigger = true
                },
                label: { Image(systemName: "chevron.right") }
            )
            Text("").hidden()
            .sheet(isPresented: $trigger) {
                EntryEdit(
                    EditableEntry(self.entry),
                    context: self.managedObjectContext,
                    products: self.products,
                    stores: self.stores,
                    storeIndex: self.$storeIndex
                )
            }
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
            Image(systemName: "chevron.right")

            Text("").hidden()
            .sheet(isPresented: $trigger) {
                StoreSelectorSheet(index: self.$index, stores: self.stores)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        EntriesView()
    }
}
