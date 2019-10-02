//
//  StoreEdit.swift
//  ShoppingList
//
//  Created by Michael Salmon on 2019-09-30.
//  Copyright © 2019 mesme. All rights reserved.
//

import CoreData
import SwiftUI

struct StoreEdit: View {
    @Environment(\.presentationMode)
    var mode: Binding<PresentationMode>

    @ObservedObject
    var store: EditableStore
    var managedObjectContext: NSManagedObjectContext

    init(_ store: EditableStore, context: NSManagedObjectContext) {
        self.store = store
        self.managedObjectContext = context
    }

    func updateStore() {
        if store.isEdit {
            store.update()
        } else {
            store.add(context: managedObjectContext)
        }
        managedObjectContext.persist()
        mode.wrappedValue.dismiss()
    }

    var body: some View {
        VStack {
            TextField(
                "Store name",
                text: $store.name,
                onCommit: { self.updateStore() }
            )
            TextField(
                "Store branch",
                text: $store.branch,
                onCommit: { self.updateStore() }
            )
            HStack {
                Button(
                    action: {
                        self.mode.wrappedValue.dismiss()
                    },
                    label: { Text("Cancel") }
                )
                Button(
                    action: { self.updateStore() },
                    label: { Text(self.store.label) }
                )
                .disabled(self.store.name.isEmpty)
            }
        }
        .padding(.horizontal, 20)
    }
}
