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

    var body: some View {
        VStack {
            StoreSelector(index: $storeIndex, stores: stores)
            List(entries.filter({ $0.storeFilter(selectedStore()) }), id: \.self) {
                EntryRow(entry: $0)
            }
        }
    }
}

struct EntryRow: View {
    @Environment(\.managedObjectContext)
    var managedObjectContext
    var entry: Quantity
    var product: Product?
    var store: Store?

    init(entry: Quantity) {
        self.entry = entry
        self.product = entry.whichProcuct?.first(where: { _ in return true }) as? Product
        self.store = entry.whichStore?.first(where: { _ in return true }) as? Store
    }

    var body: some View {
        HStack {
            Text(entry.quantity ?? "")
            Text(product?.title ?? "")
            Text(store?.title ?? "Any")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
