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
        entity: Category.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Category.name, ascending: true)
        ]
    )
    var categories: FetchedResults<Category>

    @FetchRequest(
        entity: Store.entity(),
        sortDescriptors: [
            NSSortDescriptor(keyPath: \Store.name, ascending: true)
        ]
    )
    var stores: FetchedResults<Store>

    @State
    var trigger: Bool = false

    var body: some View {
        VStack {
            List(stores, id: \.self) { store in
                StoreRow(store: store)
            }
            Button(
                action: {
                    self.trigger = true
                },
                label: { Text("New Store") }
            )
            Text("").hidden()
            .sheet(isPresented: $trigger) {
                StoreEdit(
                    EditableStore(),
                    context: self.managedObjectContext,
                    categories: self.categories
                )
            }
        }
    }
}

struct StoreRow: View {
    @Environment(\.managedObjectContext)
    var managedObjectContext

    let store: Store
    let allCategoryNames: [String]

    init(store: Store) {
        self.store = store
        self.allCategoryNames = store.allCategoryNames
    }

    var body: some View {
        HStack {
            VStack {
                Text(store.name ?? "").font(.headline)
                Text(store.branch ?? "").font(.subheadline)
            }
            Spacer()
            VStack {
                ForEach(store.allCategoryNames, id: \.self) {
                    Text($0 as String)
                }
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
