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
            List(stores, id: \.id) { store in
                StoreRow(store: store, categories: self.categories)
            }
            Button(
                action: { self.trigger = true },
                label: { EncapsulatedText("New Store") }
            )
            .buttonStyle(ShrinkPressed())

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
    let categories: FetchedResults<Category>

    init(store: Store, categories: FetchedResults<Category>) {
        self.store = store
        self.allCategoryNames = store.allCategoryNames
        self.categories = categories
    }

    @State
    var doEdit = false
    @State
    var trigger = false

    func deleteStore() {
        self.managedObjectContext.delete(self.store)
        self.managedObjectContext.persist()
    }

    var body: some View {
        HStack {
            Button(
                action: { self.trigger = true },
                label: {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(store.name ?? "")
                            .font(.headline)
                            .layoutPriority(2.0)
                            Text(store.branch ?? "")
                            .font(.subheadline)
                        }
                        Spacer()
                        VStack(alignment: .trailing) {
                            ForEach(store.allCategoryNames, id: \.self) {
                                Text($0 as String)
                                .font(.caption)
                                .layoutPriority(1.0)
                            }
                        }
                        Image(systemName: "chevron.right")
                    }
                }
            )

            Text("").hidden()
            .actionSheet(isPresented: $trigger) {
                ActionSheet(
                    title: Text("Store:"),
                    message: Text(self.store.title),
                    buttons: [
                        .default(Text("Edit"), action: { self.doEdit = true }),
                        .destructive(Text("Delete"), action: { self.deleteStore() }),
                        .cancel()
                    ]
                )
            }

            Text("").hidden()
            .sheet(isPresented: $doEdit) {
                StoreEdit(
                    EditableStore(self.store),
                    context: self.managedObjectContext,
                    categories: self.categories
                )
            }
        }
    }
}
