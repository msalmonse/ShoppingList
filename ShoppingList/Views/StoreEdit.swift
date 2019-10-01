//
//  StoreEdit.swift
//  ShoppingList
//
//  Created by Michael Salmon on 2019-09-30.
//  Copyright © 2019 mesme. All rights reserved.
//

import SwiftUI

struct StoreEdit: View {
    @Environment(\.managedObjectContext)
    var managedObjectContext
    @Environment(\.presentationMode)
    var mode: Binding<PresentationMode>

    @ObservedObject
    var store: EditableStore

    init(_ store: EditableStore) {
        self.store = store
    }

    func updateStore() {
        if store.isEdit {
            store.update()
        } else {
            store.add(Store(context: managedObjectContext))
        }
        managedObjectContext.persist()
        mode.wrappedValue.dismiss()
    }

    var body: some View {
        VStack {
            TextField("Store name", text: $store.name)
            TextField("Store branch", text: $store.branch)
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

struct StoreEdit_Previews: PreviewProvider {
    static var previews: some View {
        StoreEdit(EditableStore())
    }
}
