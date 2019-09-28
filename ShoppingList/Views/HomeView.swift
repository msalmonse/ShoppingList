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

    var body: some View {
        List(entries, id: \.self) {
            EntryRow(entry: $0)
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
            Text(product?.name ?? "")
            Text(store?.name ?? "Any")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
