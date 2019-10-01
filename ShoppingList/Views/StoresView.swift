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
                StoreEdit(EditableStore(), context: self.managedObjectContext)
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

struct StoreAdd: View {
    @Environment(\.managedObjectContext)
    var managedObjectContext

    @State
    var name = ""
    @State
    var branch = ""

    var body: some View {
        VStack {
            TextField("Store name", text: $name)
            TextField("Store branch", text: $branch)
            Button(
                action: {
                    let store = Store(context: self.managedObjectContext)
                    store.id = UUID()
                    store.name = self.name
                    store.branch = self.branch.isEmpty ? nil : self.branch
                    self.managedObjectContext.persist()
                    // clean up for next time
                    self.name = ""
                    self.branch = ""
                },
                label: { Text("Add")}
            )
            .disabled(name.isEmpty)
        }
        .padding(.horizontal, 20)
    }
}

struct StoresView_Previews: PreviewProvider {
    static var previews: some View {
        StoresView()
    }
}
