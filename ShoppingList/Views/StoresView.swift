//
//  StoresView.swift
//  ShoppingList
//
//  Created by Michael Salmon on 2019-09-27.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI

struct StoresView: View {
    @Environment(\.managedObjectContext)
    var managedObjectContext

    @FetchRequest(
        entity: Store.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Store.name, ascending: true)
        ]
    )
    var stores: FetchedResults<Store>

    var body: some View {
        VStack {
            StoreAddLink()
            List(stores, id: \.self) { store in
                StoreRow(store: store)
            }
        }
    }
}

struct StoreRow: View {
    @Environment(\.managedObjectContext)
    var managedObjectContext

    let store: Store

    var body: some View {
        HStack {
            VStack {
                Text(store.name ?? "").font(.headline)
                Text(store.branch ?? "").font(.subheadline)
            }
            Spacer()
            Button(
                action: {
                    self.managedObjectContext.delete(self.store)
                    self.managedObjectContext.persist()
                },
                label: { Image(systemName: "clear").foregroundColor(.red) }
            )
        }
    }
}

struct StoresView_Previews: PreviewProvider {
    static var previews: some View {
        StoresView()
    }
}
